Return-Path: <cgroups+bounces-530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E707F5910
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 08:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E22B20F30
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 07:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D90715ACE;
	Thu, 23 Nov 2023 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mtmk0lNQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DD100;
	Wed, 22 Nov 2023 23:20:01 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1044E120071;
	Thu, 23 Nov 2023 10:20:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1044E120071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700724000;
	bh=FqpWkqFlCXy5e8M9JPLBeFC7vxG1fv8P80GWkWslETo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mtmk0lNQIHJ+w3JQvX+Fg7IrkYNKjHPHvktagFO4wXgd6zM21fmy3drWFlgrBaPcQ
	 8io4+0ZIjsazgOMbX5IP8Y4cxZieQh+II8JQlYRblDDE5AnXsqJvDGh+KjXxpROD4w
	 SOeU2ZAYuA8Km1kJEe3GTaHxnymJMRur9+zYbDGGYryJ+EIe6slEa8TANxfWrhA3iY
	 pXG416DuqQjiGOLtnpu3XWCjsZGXZoo2BRnO4BK8IZvft/Wo9tmX+XHvWaSGsXMkjj
	 IGBsgrrYjs0tGE32PmmBTjO90PDiAD5WftT1YyThe6h4aGdUq04lQbH97YTIsFP/Bi
	 gQuGBh69GI/mg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 10:19:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 10:19:59 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeelb@google.com>, <muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 2/3] samples/cgroup: introduce memcg memory.events listener
Date: Thu, 23 Nov 2023 10:19:44 +0300
Message-ID: <20231123071945.25811-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231123071945.25811-1-ddrokosov@salutedevices.com>
References: <20231123071945.25811-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181550 [Nov 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 04:50:00 #22507336
X-KSMG-AntiVirus-Status: Clean, skipped

This is a simple listener for memory events that handles counter
changes in runtime. It can be set up for a specific memory cgroup v2.

The output example:
=====
$ /tmp/memcg_event_listener test
Initialized MEMCG events with counters:
MEMCG events:
	low: 0
	high: 0
	max: 0
	oom: 0
	oom_kill: 0
	oom_group_kill: 0
Started monitoring memory events from '/sys/fs/cgroup/test/memory.events'...
Received event in /sys/fs/cgroup/test/memory.events:
*** 1 MEMCG oom_kill event, change counter 0 => 1
Received event in /sys/fs/cgroup/test/memory.events:
*** 1 MEMCG oom_kill event, change counter 1 => 2
Received event in /sys/fs/cgroup/test/memory.events:
*** 1 MEMCG oom_kill event, change counter 2 => 3
Received event in /sys/fs/cgroup/test/memory.events:
*** 1 MEMCG oom_kill event, change counter 3 => 4
Received event in /sys/fs/cgroup/test/memory.events:
*** 2 MEMCG max events, change counter 0 => 2
Received event in /sys/fs/cgroup/test/memory.events:
*** 8 MEMCG max events, change counter 2 => 10
*** 1 MEMCG oom event, change counter 0 => 1
Received event in /sys/fs/cgroup/test/memory.events:
*** 1 MEMCG oom_kill event, change counter 4 => 5
^CExiting memcg event listener...
=====

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 samples/cgroup/Makefile               |   2 +-
 samples/cgroup/memcg_event_listener.c | 330 ++++++++++++++++++++++++++
 2 files changed, 331 insertions(+), 1 deletion(-)
 create mode 100644 samples/cgroup/memcg_event_listener.c

diff --git a/samples/cgroup/Makefile b/samples/cgroup/Makefile
index deef4530f5e7..526c8569707c 100644
--- a/samples/cgroup/Makefile
+++ b/samples/cgroup/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-userprogs-always-y += cgroup_event_listener
+userprogs-always-y += cgroup_event_listener memcg_event_listener
 
 userccflags += -I usr/include
diff --git a/samples/cgroup/memcg_event_listener.c b/samples/cgroup/memcg_event_listener.c
new file mode 100644
index 000000000000..a1667fe2489a
--- /dev/null
+++ b/samples/cgroup/memcg_event_listener.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * memcg_event_listener.c - Simple listener of memcg memory.events
+ *
+ * Copyright (c) 2023, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
+ */
+
+#include <err.h>
+#include <errno.h>
+#include <limits.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/inotify.h>
+#include <unistd.h>
+
+#define MEMCG_EVENTS "memory.events"
+
+/* Size of buffer to use when reading inotify events */
+#define INOTIFY_BUFFER_SIZE 8192
+
+#define INOTIFY_EVENT_NEXT(event, length) ({         \
+	(length) -= sizeof(*(event)) + (event)->len; \
+	(event)++;                                   \
+})
+
+#define INOTIFY_EVENT_OK(event, length) ((length) >= (ssize_t)sizeof(*(event)))
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+
+struct memcg_counters {
+	long low;
+	long high;
+	long max;
+	long oom;
+	long oom_kill;
+	long oom_group_kill;
+};
+
+struct memcg_events {
+	struct memcg_counters counters;
+	char path[PATH_MAX];
+	int inotify_fd;
+	int inotify_wd;
+};
+
+static void print_memcg_counters(const struct memcg_counters *counters)
+{
+	printf("MEMCG events:\n");
+	printf("\tlow: %ld\n", counters->low);
+	printf("\thigh: %ld\n", counters->high);
+	printf("\tmax: %ld\n", counters->max);
+	printf("\toom: %ld\n", counters->oom);
+	printf("\toom_kill: %ld\n", counters->oom_kill);
+	printf("\toom_group_kill: %ld\n", counters->oom_group_kill);
+}
+
+static int get_memcg_counter(char *line, const char *name, long *counter)
+{
+	size_t len = strlen(name);
+	char *endptr;
+	long tmp;
+
+	if (memcmp(line, name, len)) {
+		warnx("Counter line %s has wrong name, %s is expected",
+		      line, name);
+		return -EINVAL;
+	}
+
+	/* skip the whitespace delimiter */
+	len += 1;
+
+	errno = 0;
+	tmp = strtol(&line[len], &endptr, 10);
+	if (((tmp == LONG_MAX || tmp == LONG_MIN) && errno == ERANGE) ||
+	    (errno && !tmp)) {
+		warnx("Failed to parse: %s", &line[len]);
+		return -ERANGE;
+	}
+
+	if (endptr == &line[len]) {
+		warnx("Not digits were found in line %s", &line[len]);
+		return -EINVAL;
+	}
+
+	if (!(*endptr == '\0' || (*endptr == '\n' && *++endptr == '\0'))) {
+		warnx("Further characters after number: %s", endptr);
+		return -EINVAL;
+	}
+
+	*counter = tmp;
+
+	return 0;
+}
+
+static int read_memcg_events(struct memcg_events *events, bool show_diff)
+{
+	FILE *fp = fopen(events->path, "re");
+	size_t i;
+	int ret = 0;
+	bool any_new_events = false;
+	char *line = NULL;
+	size_t len = 0;
+	struct memcg_counters new_counters;
+	struct memcg_counters *counters = &events->counters;
+	struct {
+		const char *name;
+		long *new;
+		long *old;
+	} map[] = {
+		{
+			.name = "low",
+			.new = &new_counters.low,
+			.old = &counters->low,
+		},
+		{
+			.name = "high",
+			.new = &new_counters.high,
+			.old = &counters->high,
+		},
+		{
+			.name = "max",
+			.new = &new_counters.max,
+			.old = &counters->max,
+		},
+		{
+			.name = "oom",
+			.new = &new_counters.oom,
+			.old = &counters->oom,
+		},
+		{
+			.name = "oom_kill",
+			.new = &new_counters.oom_kill,
+			.old = &counters->oom_kill,
+		},
+		{
+			.name = "oom_group_kill",
+			.new = &new_counters.oom_group_kill,
+			.old = &counters->oom_group_kill,
+		},
+	};
+
+	if (!fp) {
+		warn("Failed to open memcg events file %s", events->path);
+		return -EBADF;
+	}
+
+	/* Read new values for memcg counters */
+	for (i = 0; i < ARRAY_SIZE(map); ++i) {
+		ssize_t nread;
+
+		errno = 0;
+		nread = getline(&line, &len, fp);
+		if (nread == -1) {
+			if (errno) {
+				warn("Failed to read line for counter %s",
+				     map[i].name);
+				ret = -EIO;
+				goto exit;
+			}
+
+			break;
+		}
+
+		ret = get_memcg_counter(line, map[i].name, map[i].new);
+		if (ret) {
+			warnx("Failed to get counter value from line %s", line);
+			goto exit;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(map); ++i) {
+		long diff;
+
+		if (*map[i].new > *map[i].old) {
+			diff = *map[i].new - *map[i].old;
+
+			if (show_diff)
+				printf("*** %ld MEMCG %s event%s, "
+				       "change counter %ld => %ld\n",
+				       diff, map[i].name,
+				       (diff == 1) ? "" : "s",
+				       *map[i].old, *map[i].new);
+
+			*map[i].old += diff;
+			any_new_events = true;
+		}
+	}
+
+	if (show_diff && !any_new_events)
+		printf("*** No new untracked memcg events available\n");
+
+exit:
+	free(line);
+	fclose(fp);
+
+	return ret;
+}
+
+static void process_memcg_events(struct memcg_events *events,
+				 struct inotify_event *event)
+{
+	int ret;
+
+	if (events->inotify_wd != event->wd) {
+		warnx("Unknown inotify event %d, should be %d", event->wd,
+		      events->inotify_wd);
+		return;
+	}
+
+	printf("Received event in %s:\n", events->path);
+
+	if (!(event->mask & IN_MODIFY)) {
+		warnx("No IN_MODIFY event, skip it");
+		return;
+	}
+
+	ret = read_memcg_events(events, /* show_diff = */true);
+	if (ret)
+		warnx("Can't read memcg events");
+}
+
+static void monitor_events(struct memcg_events *events)
+{
+	struct pollfd fds[1];
+	int ret;
+
+	printf("Started monitoring memory events from '%s'...\n", events->path);
+
+	fds[0].fd = events->inotify_fd;
+	fds[0].events = POLLIN;
+
+	for (;;) {
+		ret = poll(fds, ARRAY_SIZE(fds), -1);
+		if (ret < 0 && errno != EAGAIN)
+			err(EXIT_FAILURE, "Can't poll memcg events (%d)", ret);
+
+		if (fds[0].revents & POLLERR)
+			err(EXIT_FAILURE, "Got POLLERR during monitor events");
+
+		if (fds[0].revents & POLLIN) {
+			struct inotify_event *event;
+			char buffer[INOTIFY_BUFFER_SIZE];
+			ssize_t length;
+
+			length = read(fds[0].fd, buffer, INOTIFY_BUFFER_SIZE);
+			if (length <= 0)
+				continue;
+
+			event = (struct inotify_event *)buffer;
+			while (INOTIFY_EVENT_OK(event, length)) {
+				process_memcg_events(events, event);
+				event = INOTIFY_EVENT_NEXT(event, length);
+			}
+		}
+	}
+}
+
+static int initialize_memcg_events(struct memcg_events *events,
+				   const char *cgroup)
+{
+	int ret;
+
+	memset(events, 0, sizeof(struct memcg_events));
+
+	ret = snprintf(events->path, PATH_MAX,
+		       "/sys/fs/cgroup/%s/memory.events", cgroup);
+	if (ret >= PATH_MAX) {
+		warnx("Path to cgroup memory.events is too long");
+		return -EMSGSIZE;
+	} else if (ret < 0) {
+		warn("Can't generate cgroup event full name");
+		return ret;
+	}
+
+	ret = read_memcg_events(events, /* show_diff = */false);
+	if (ret) {
+		warnx("Failed to read initial memcg events state (%d)", ret);
+		return ret;
+	}
+
+	events->inotify_fd = inotify_init();
+	if (events->inotify_fd < 0) {
+		warn("Failed to setup new inotify device");
+		return -EMFILE;
+	}
+
+	events->inotify_wd = inotify_add_watch(events->inotify_fd,
+					       events->path, IN_MODIFY);
+	if (events->inotify_wd < 0) {
+		warn("Couldn't add monitor in dir %s", events->path);
+		return -EIO;
+	}
+
+	printf("Initialized MEMCG events with counters:\n");
+	print_memcg_counters(&events->counters);
+
+	return 0;
+}
+
+static void cleanup_memcg_events(struct memcg_events *events)
+{
+	inotify_rm_watch(events->inotify_fd, events->inotify_wd);
+	close(events->inotify_fd);
+}
+
+int main(int argc, const char **argv)
+{
+	struct memcg_events events;
+	ssize_t ret;
+
+	if (argc != 2)
+		errx(EXIT_FAILURE, "Usage: %s <cgroup>", argv[0]);
+
+	ret = initialize_memcg_events(&events, argv[1]);
+	if (ret)
+		errx(EXIT_FAILURE, "Can't initialize memcg events (%zd)", ret);
+
+	monitor_events(&events);
+
+	cleanup_memcg_events(&events);
+
+	printf("Exiting memcg event listener...\n");
+
+	return EXIT_SUCCESS;
+}
-- 
2.36.0


