Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A37598F32
	for <lists+cgroups@lfdr.de>; Thu, 18 Aug 2022 23:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbiHRVLW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Aug 2022 17:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346759AbiHRVK3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Aug 2022 17:10:29 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC05D3EE6
        for <cgroups@vger.kernel.org>; Thu, 18 Aug 2022 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=HQUnJK+uLeZwjTpp2+z61Sk9IGp
        2r7zEuY9wjhAxDYo=; b=32csxGwPTmshT51RhlOX/Cm6CR3mc1tQhVPU6HueEDD
        B6eN+0sGodIpjYFWeu07yrAKz6sgmPDVCdYrjr7uDtth49DZJdR1hIo7iir0S1Hx
        TdKxLKznufYoO8hhh0xVl0vzqMjzOc7bohomzoMjWpfXcyYffAj0p0sXec+73gIk
        =
Received: (qmail 3962787 invoked from network); 18 Aug 2022 23:02:03 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2022 23:02:03 +0200
X-UD-Smtp-Session: l3s3148p1@BOQKS4rm79cucref
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] kernel: move from strlcpy with unused retval to strscpy
Date:   Thu, 18 Aug 2022 23:02:01 +0200
Message-Id: <20220818210202.8227-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Follow the advice of the below link and prefer 'strscpy' in this
subsystem. Conversion is 1:1 because the return value is not used.
Generated by a coccinelle script.

Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 kernel/acct.c                         |  2 +-
 kernel/bpf/preload/bpf_preload_kern.c |  4 ++--
 kernel/cgroup/cgroup-v1.c             |  4 ++--
 kernel/events/core.c                  |  6 +++---
 kernel/kallsyms.c                     |  4 ++--
 kernel/params.c                       |  2 +-
 kernel/printk/printk.c                |  2 +-
 kernel/relay.c                        |  4 ++--
 kernel/time/clocksource.c             |  2 +-
 kernel/trace/ftrace.c                 | 18 +++++++++---------
 kernel/trace/trace.c                  |  8 ++++----
 kernel/trace/trace_events.c           |  2 +-
 kernel/trace/trace_events_inject.c    |  4 ++--
 kernel/trace/trace_kprobe.c           |  2 +-
 kernel/trace/trace_probe.c            |  2 +-
 15 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 13706356ec54..5ee0b37acf0c 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -443,7 +443,7 @@ static void fill_ac(acct_t *ac)
 	memset(ac, 0, sizeof(acct_t));
 
 	ac->ac_version = ACCT_VERSION | ACCT_BYTEORDER;
-	strlcpy(ac->ac_comm, current->comm, sizeof(ac->ac_comm));
+	strscpy(ac->ac_comm, current->comm, sizeof(ac->ac_comm));
 
 	/* calculate run_time in nsec*/
 	run_time = ktime_get_ns();
diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 5106b5372f0c..af8dd3a7c928 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -19,9 +19,9 @@ static void free_links_and_skel(void)
 
 static int preload(struct bpf_preload_info *obj)
 {
-	strlcpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
+	strscpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
 	obj[0].link = maps_link;
-	strlcpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
+	strscpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
 	obj[1].link = progs_link;
 	return 0;
 }
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 2ade21b54dc4..ce8bcd2d014a 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -563,7 +563,7 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
 	if (!cgrp)
 		return -ENODEV;
 	spin_lock(&release_agent_path_lock);
-	strlcpy(cgrp->root->release_agent_path, strstrip(buf),
+	strscpy(cgrp->root->release_agent_path, strstrip(buf),
 		sizeof(cgrp->root->release_agent_path));
 	spin_unlock(&release_agent_path_lock);
 	cgroup_kn_unlock(of->kn);
@@ -797,7 +797,7 @@ void cgroup1_release_agent(struct work_struct *work)
 		goto out_free;
 
 	spin_lock(&release_agent_path_lock);
-	strlcpy(agentbuf, cgrp->root->release_agent_path, PATH_MAX);
+	strscpy(agentbuf, cgrp->root->release_agent_path, PATH_MAX);
 	spin_unlock(&release_agent_path_lock);
 	if (!agentbuf[0])
 		goto out_free;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..7c785b64fa3d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7954,7 +7954,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	unsigned int size;
 
 	memset(comm, 0, sizeof(comm));
-	strlcpy(comm, comm_event->task->comm, sizeof(comm));
+	strscpy(comm, comm_event->task->comm, sizeof(comm));
 	size = ALIGN(strlen(comm)+1, sizeof(u64));
 
 	comm_event->comm = comm;
@@ -8409,7 +8409,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	}
 
 cpy_name:
-	strlcpy(tmp, name, sizeof(tmp));
+	strscpy(tmp, name, sizeof(tmp));
 	name = tmp;
 got_name:
 	/*
@@ -8838,7 +8838,7 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
 	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
 		goto err;
 
-	strlcpy(name, sym, KSYM_NAME_LEN);
+	strscpy(name, sym, KSYM_NAME_LEN);
 	name_len = strlen(name) + 1;
 	while (!IS_ALIGNED(name_len, sizeof(u64)))
 		name[name_len++] = '\0';
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3e7e2c2ad2f7..9a204432bf87 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -624,7 +624,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 {
 	int ret;
 
-	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
+	strscpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
@@ -644,7 +644,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
  */
 static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
-	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
+	strscpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c5..ee2e3b674dd0 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -846,7 +846,7 @@ static void __init param_sysfs_builtin(void)
 			name_len = 0;
 		} else {
 			name_len = dot - kp->name + 1;
-			strlcpy(modname, kp->name, name_len);
+			strscpy(modname, kp->name, name_len);
 		}
 		kernel_add_sysfs_param(modname, kp, name_len);
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a1a81fd9889b..7b1ba087b629 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2392,7 +2392,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		return -E2BIG;
 	if (!brl_options)
 		preferred_console = i;
-	strlcpy(c->name, name, sizeof(c->name));
+	strscpy(c->name, name, sizeof(c->name));
 	c->options = options;
 	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
diff --git a/kernel/relay.c b/kernel/relay.c
index 6a611e779e95..e75bc76c8bfa 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -510,7 +510,7 @@ struct rchan *relay_open(const char *base_filename,
 	chan->private_data = private_data;
 	if (base_filename) {
 		chan->has_base_filename = 1;
-		strlcpy(chan->base_filename, base_filename, NAME_MAX);
+		strscpy(chan->base_filename, base_filename, NAME_MAX);
 	}
 	chan->cb = cb;
 	kref_init(&chan->kref);
@@ -581,7 +581,7 @@ int relay_late_setup_files(struct rchan *chan,
 	if (!chan || !base_filename)
 		return -EINVAL;
 
-	strlcpy(chan->base_filename, base_filename, NAME_MAX);
+	strscpy(chan->base_filename, base_filename, NAME_MAX);
 
 	mutex_lock(&relay_channels_mutex);
 	/* Is chan already set up? */
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cee5da1e54c4..dc95af1fc8cd 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1450,7 +1450,7 @@ static int __init boot_override_clocksource(char* str)
 {
 	mutex_lock(&clocksource_mutex);
 	if (str)
-		strlcpy(override_name, str, sizeof(override_name));
+		strscpy(override_name, str, sizeof(override_name));
 	mutex_unlock(&clocksource_mutex);
 	return 1;
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..654cd8ca46b9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5991,7 +5991,7 @@ bool ftrace_filter_param __initdata;
 static int __init set_ftrace_notrace(char *str)
 {
 	ftrace_filter_param = true;
-	strlcpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
+	strscpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_notrace=", set_ftrace_notrace);
@@ -5999,7 +5999,7 @@ __setup("ftrace_notrace=", set_ftrace_notrace);
 static int __init set_ftrace_filter(char *str)
 {
 	ftrace_filter_param = true;
-	strlcpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
+	strscpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_filter=", set_ftrace_filter);
@@ -6011,14 +6011,14 @@ static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
 
 static int __init set_graph_function(char *str)
 {
-	strlcpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
+	strscpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_graph_filter=", set_graph_function);
 
 static int __init set_graph_notrace_function(char *str)
 {
-	strlcpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
+	strscpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_graph_notrace=", set_graph_notrace_function);
@@ -6803,8 +6803,8 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,
 			continue;
 		*value = op->trampoline;
 		*type = 't';
-		strlcpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
-		strlcpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
+		strscpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
+		strscpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
 		*exported = 0;
 		return 0;
 	}
@@ -7135,7 +7135,7 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 		if (off)
 			*off = addr - found_func->ip;
 		if (sym)
-			strlcpy(sym, found_func->name, KSYM_NAME_LEN);
+			strscpy(sym, found_func->name, KSYM_NAME_LEN);
 
 		return found_func->name;
 	}
@@ -7189,8 +7189,8 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 
 			*value = mod_func->ip;
 			*type = 'T';
-			strlcpy(name, mod_func->name, KSYM_NAME_LEN);
-			strlcpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
+			strscpy(name, mod_func->name, KSYM_NAME_LEN);
+			strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
 			*exported = 1;
 			preempt_enable();
 			return 0;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3005279165d..98ce29d78110 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -189,7 +189,7 @@ static bool snapshot_at_boot;
 
 static int __init set_cmdline_ftrace(char *str)
 {
-	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
+	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
 	default_bootup_tracer = bootup_tracer_buf;
 	/* We are using ftrace early, expand it */
 	ring_buffer_expanded = true;
@@ -244,7 +244,7 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 
 static int __init set_trace_boot_options(char *str)
 {
-	strlcpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
+	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
 	return 1;
 }
 __setup("trace_options=", set_trace_boot_options);
@@ -254,7 +254,7 @@ static char *trace_boot_clock __initdata;
 
 static int __init set_trace_boot_clock(char *str)
 {
-	strlcpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
+	strscpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
 	trace_boot_clock = trace_boot_clock_buf;
 	return 1;
 }
@@ -2452,7 +2452,7 @@ static void __trace_find_cmdline(int pid, char comm[])
 	if (map != NO_CMDLINE_MAP) {
 		tpid = savedcmd->map_cmdline_to_pid[map];
 		if (tpid == pid) {
-			strlcpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
+			strscpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
 			return;
 		}
 	}
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 181f08186d32..c2e65c646980 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3531,7 +3531,7 @@ static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
 
 static __init int setup_trace_event(char *str)
 {
-	strlcpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	strscpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
 	ring_buffer_expanded = true;
 	disable_tracing_selftest("running event tracing");
 
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index d6b4935a78c0..abe805d471eb 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -217,7 +217,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 			char *addr = (char *)(unsigned long) val;
 
 			if (field->filter_type == FILTER_STATIC_STRING) {
-				strlcpy(entry + field->offset, addr, field->size);
+				strscpy(entry + field->offset, addr, field->size);
 			} else if (field->filter_type == FILTER_DYN_STRING ||
 				   field->filter_type == FILTER_RDYN_STRING) {
 				int str_len = strlen(addr) + 1;
@@ -232,7 +232,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 				}
 				entry = *pentry;
 
-				strlcpy(entry + (entry_size - str_len), addr, str_len);
+				strscpy(entry + (entry_size - str_len), addr, str_len);
 				str_item = (u32 *)(entry + field->offset);
 				if (field->filter_type == FILTER_RDYN_STRING)
 					str_loc -= field->offset + field->size;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 23f7f0ec4f4c..0f0262edb48a 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -29,7 +29,7 @@ static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
 
 static int __init set_kprobe_boot_events(char *str)
 {
-	strlcpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
+	strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
 	disable_tracing_selftest("running kprobe events");
 
 	return 1;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 850a88abd33b..24da9a2ce070 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -245,7 +245,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 			trace_probe_log_err(offset, GROUP_TOO_LONG);
 			return -EINVAL;
 		}
-		strlcpy(buf, event, slash - event + 1);
+		strscpy(buf, event, slash - event + 1);
 		if (!is_good_name(buf)) {
 			trace_probe_log_err(offset, BAD_GROUP_NAME);
 			return -EINVAL;
-- 
2.35.1

