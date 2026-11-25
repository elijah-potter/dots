import { StringEnum } from "@earendil-works/pi-ai";
import {
	type ExtensionAPI,
	truncateHead,
} from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";

/**
 * Register model discovery and session-only switching without confirmation.
 * Pi records changes in session history; defaults for new sessions stay unchanged.
 */
export default function modelSwitch(pi: ExtensionAPI) {
	pi.registerTool({
		name: "model_switch",
		label: "Model Switch",
		description:
			"List authenticated chat models or switch the current session model without confirmation. " +
			"Use exact provider and modelId values from list. New-session defaults stay unchanged. " +
			"List output is limited to 2000 lines or 50 KB; use provider to filter it.",
		promptSnippet: "List available models or switch the current session model",
		executionMode: "sequential",
		parameters: Type.Object({
			action: StringEnum(["list", "switch"] as const),
			provider: Type.Optional(
				Type.String({
					description:
						"Exact provider ID; required for switch, optional list filter.",
				}),
			),
			modelId: Type.Optional(
				Type.String({ description: "Exact model ID; required for switch." }),
			),
		}),
		async execute(_toolCallId, params, signal, _onUpdate, ctx) {
			signal?.throwIfAborted();
			const previous = ctx.model
				? `${ctx.model.provider}/${ctx.model.id}`
				: "none";

			if (params.action === "list") {
				const models = ctx.modelRegistry
					.getAvailable()
					.filter(
						(model) => !params.provider || model.provider === params.provider,
					)
					.map(({ provider, id }) => JSON.stringify({ provider, modelId: id }));
				const output = truncateHead(
					`Current model: ${previous}\nAvailable models: ${models.length}\n${models.join("\n")}`,
				);
				return {
					content: [
						{
							type: "text",
							text:
								output.content +
								(output.truncated
									? "\nList truncated. Filter by provider."
									: ""),
						},
					],
					details: {},
				};
			}

			if (!params.provider || !params.modelId) {
				throw new Error(
					"Switch requires provider and modelId. Use action list to find exact IDs.",
				);
			}
			const model = ctx.modelRegistry.find(params.provider, params.modelId);
			if (!model) {
				throw new Error(
					`Unknown model: ${params.provider}/${params.modelId}. Use action list.`,
				);
			}
			const selected = `${model.provider}/${model.id}`;
			if (ctx.model?.provider === model.provider && ctx.model.id === model.id) {
				return {
					content: [{ type: "text", text: `Model unchanged: ${selected}.` }],
					details: {},
				};
			}
			if (!(await pi.setModel(model))) {
				throw new Error(
					`Authentication is not configured for provider: ${model.provider}.`,
				);
			}
			return {
				content: [
					{
						type: "text",
						text: `Model switched from ${previous} to ${selected}. The next model request uses the selected model. New-session defaults are unchanged.`,
					},
				],
				details: {},
			};
		},
	});
}
