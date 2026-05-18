local mc_schema_url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main"

return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	settings = {
		json = {
			validate = { enable = true },
			schemas = {
				{
					description = "Minecraft Bedrock Manifest",
					fileMatch = { "manifest.json", "manifest.jsonc", "manifest.json5" },
					url = mc_schema_url .. "/general/manifest.json",
				},
				{
					description = "Minecraft Bedrock World Packs",
					fileMatch = {
						"world_behavior_packs.json",
						"world_behavior_packs.jsonc",
						"world_behavior_packs.json5",
						"world_resource_packs.json",
						"world_resource_packs.jsonc",
						"world_resource_packs.json5",
					},
					url = mc_schema_url .. "/general/world_x_packs.json",
				},

				{
					description = "Minecraft Bedrock Language Names",
					fileMatch = { "language_names.json", "language_names.jsonc", "language_names.json5" },
					url = mc_schema_url .. "/language/language_names.json",
				},
				{
					description = "Minecraft Bedrock Languages",
					fileMatch = { "languages.json", "languages.jsonc", "languages.json5" },
					url = mc_schema_url .. "/language/languages.json",
				},

				{
					description = "Minecraft Bedrock Skin Pack",
					fileMatch = { "skin_pack/skins.json", "skin_pack/skins.jsonc", "skin_pack/skins.json5" },
					url = mc_schema_url .. "/skinpacks/skins.json",
				},

				{
					description = "Minecraft Bedrock Resource Pack Animation Controllers",
					fileMatch = {
						"resource_packs/*/animation_controllers/*.json",
						"resource_packs/*/animation_controllers/*.jsonc",
						"resource_packs/*/animation_controllers/*.json5",
						"*resource*pack*/animation_controllers/*.json",
						"*resource*pack*/animation_controllers/*.jsonc",
						"*resource*pack*/animation_controllers/*.json5",
						"*Resource*Pack*/animation_controllers/*.json",
						"*RP*/animation_controllers/*.json",
						"*rp*/animation_controllers/*.json",
						"*.animation_controller.rp.json",
						"*.rpac.json",
						"*.ac.rp.json",
						"*.rp_ac.json",
					},
					url = mc_schema_url .. "/resource/animation_controllers/animation_controller.json",
				},
				{
					description = "Minecraft Bedrock Resource Pack Animations",
					fileMatch = {
						"resource_packs/*/animations/*.json",
						"*resource*pack*/animations/*.json",
						"*Resource*Pack*/animations/*.json",
						"*RP*/animations/*.json",
						"*rp*/animations/*.json",
						"*.animation.rp.json",
						"*.anim.rp.json",
						"*.a.rp.json",
						"*.rpa.json",
					},
					url = mc_schema_url .. "/resource/animations/actor_animation.json",
				},
				{
					description = "Minecraft Bedrock Attachables",
					fileMatch = {
						"attachables/*.json",
						"*.attachable.json",
						"*.attach.json",
						"*.at.json",
					},
					url = mc_schema_url .. "/resource/attachables/attachables.json",
				},
				{
					description = "Minecraft Bedrock Client Biomes",
					fileMatch = { "biomes_client.json", "biomes_client.jsonc", "biomes_client.json5" },
					url = mc_schema_url .. "/resource/biomes_client.json",
				},
				{
					description = "Minecraft Bedrock Resource Blocks",
					fileMatch = { "blocks.json", "blocks.jsonc", "blocks.json5" },
					url = mc_schema_url .. "/resource/blocks.json",
				},
				{
					description = "Minecraft Bedrock Client Entity",
					fileMatch = {
						"entity/*.json",
						"*.entity.rp.json",
						"*.e.rp.json",
						"*.ce.json",
						"*.rpe.json",
						"*.entity.json",
					},
					url = mc_schema_url .. "/resource/entity/entity.json",
				},
				{
					description = "Minecraft Bedrock Fogs",
					fileMatch = {
						"fogs/*.json",
						"*.fog.json",
					},
					url = mc_schema_url .. "/resource/fog/fog.json",
				},
				{
					description = "Minecraft Bedrock Flipbook Textures",
					fileMatch = { "flipbook_textures.json", "flipbook_textures.jsonc", "flipbook_textures.json5" },
					url = mc_schema_url .. "/resource/textures/flipbook_textures.json",
				},
				{
					description = "Minecraft Bedrock Item Texture",
					fileMatch = { "item_texture.json", "item_texture.jsonc", "item_texture.json5" },
					url = mc_schema_url .. "/resource/textures/item_texture.json",
				},
				{
					description = "Minecraft Bedrock Texture List",
					fileMatch = { "texture_list.json", "texture_list.jsonc", "texture_list.json5" },
					url = mc_schema_url .. "/resource/textures/texture_list.json",
				},
				{
					description = "Minecraft Bedrock Resource Pack Items",
					fileMatch = {
						"resource_packs/*/items/*.json",
						"*resource*pack*/items/*.json",
						"*RP*/items/*.json",
						"*.item.rp.json",
						"*.i.rp.json",
						"*.rpi.json",
					},
					url = mc_schema_url .. "/resource/items/items.json",
				},
				{
					description = "Minecraft Bedrock Entity Models",
					fileMatch = {
						"models/entity/*.json",
						"*.geo.json",
						"*.geometry.json",
						"*.model.json",
						"*.g.json",
					},
					url = mc_schema_url .. "/resource/models/entity/model_entity.json",
				},
				{
					description = "Minecraft Bedrock Materials",
					fileMatch = { "materials/*.material" },
					url = mc_schema_url .. "/resource/materials/materials.json",
				},
				{
					description = "Minecraft Bedrock Music Definitions",
					fileMatch = { "music_definitions.json" },
					url = mc_schema_url .. "/resource/sounds/music_definitions.json",
				},
				{
					description = "Minecraft Bedrock Particles",
					fileMatch = {
						"particles/*.json",
						"*.particle.json",
						"*.p.json",
					},
					url = mc_schema_url .. "/resource/particles/particles.json",
				},
				{
					description = "Minecraft Bedrock Render Controllers",
					fileMatch = {
						"render_controllers/*.json",
						"*.render.json",
						"*.render_controller.json",
						"*.rc.json",
					},
					url = mc_schema_url .. "/resource/render_controllers/render_controllers.json",
				},
				{
					description = "Minecraft Bedrock Sound Definitions",
					fileMatch = { "sound_definitions.json" },
					url = mc_schema_url .. "/resource/sounds/sound_definitions.json",
				},
				{
					description = "Minecraft Bedrock Sounds UI",
					fileMatch = { "sounds.json" },
					url = mc_schema_url .. "/resource/sounds/sounds.json",
				},

				-- Behavior Pack schemas
				{
					description = "Minecraft Bedrock Behavior Pack Animation Controllers",
					fileMatch = {
						"behavior_packs/*/animation_controllers/*.json",
						"*behavior*pack*/animation_controllers/*.json",
						"*BP*/animation_controllers/*.json",
						"*bp*/animation_controllers/*.json",
						"*.animation_controller.bp.json",
						"*.bpac.json",
						"*.ac.bp.json",
					},
					url = mc_schema_url .. "/behavior/animation_controllers/animation_controller.json",
				},
				{
					description = "Minecraft Bedrock Behavior Pack Animations",
					fileMatch = {
						"behavior_packs/*/animations/*.json",
						"*behavior*pack*/animations/*.json",
						"*BP*/animations/*.json",
						"*.animation.bp.json",
						"*.bp_anim.json",
						"*.bpa.json",
					},
					url = mc_schema_url .. "/behavior/animations/actor_animation.json",
				},
				{
					description = "Minecraft Bedrock Biomes",
					fileMatch = { "biomes/*.json", "biomes/**/*.json" },
					url = mc_schema_url .. "/behavior/biomes/biomes.json",
				},
				{
					description = "Minecraft Bedrock Server Entity",
					fileMatch = {
						"entities/*.json",
						"entities/**/*.json",
						"*.entity.bp.json",
						"*.bpe.json",
					},
					url = mc_schema_url .. "/behavior/entities/entities.json",
				},
				{
					description = "Minecraft Bedrock Server Item",
					fileMatch = {
						"behavior_packs/*/items/*.json",
						"behavior_packs/*/items/**/*.json",
						"*behavior*pack*/items/*.json",
						"*BP*/items/*.json",
						"*.item.bp.json",
						"*.bpi.json",
					},
					url = mc_schema_url .. "/behavior/items/items.json",
				},
				{
					description = "Minecraft Bedrock Loot Tables",
					fileMatch = { "loot_tables/*.json", "loot_tables/**/*.json" },
					url = mc_schema_url .. "/behavior/loot_tables/loot_tables.json",
				},
				{
					description = "Minecraft Bedrock Recipes",
					fileMatch = { "recipes/*.json", "recipes/**/*.json" },
					url = mc_schema_url .. "/behavior/recipes/recipes.json",
				},
				{
					description = "Minecraft Bedrock Trading",
					fileMatch = { "trading/*.json", "trading/**/*.json" },
					url = mc_schema_url .. "/behavior/trading/trading.json",
				},
			},
		},
	},
}
