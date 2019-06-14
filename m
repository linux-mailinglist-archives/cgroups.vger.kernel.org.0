Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697DA4517D
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfFNB5A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:57:00 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:46862 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfFNB5A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:57:00 -0400
Received: by mail-pg1-f171.google.com with SMTP id v9so551683pgr.13;
        Thu, 13 Jun 2019 18:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JRLyNxpw7AvNmeQZzP4O/C4kwoZ5qKtRHpUpLuw/LXw=;
        b=XlqlR8YURXj48F9ebYGMFgF7hvtjnIasUi6aZ/R0MyhwY7+3s4N//ot0IMpAblg+Yx
         vzEfgHfiZngFGGjinuqGnIopXiYOdra7PfhkdXw50kaCMR3uAb3kd9IviVK2YAUTHYgy
         RF12c/p5zUZTfHDjtzV6SKhHhX9fWpNvB23HuJm9f8lPZc2TT65/eZ5LysfFX7aIT31K
         d6FLs4UzbYTo82yrO91m4touDjo/aQT85mfuuDgkO15+TJW0PkmV4lW2AEtc7SVu0mms
         nmOpOyZqacZou3UqRpHIaqUMunzHCKNGTu89xEvd3nbfFNyQiP815jjKMIyaUxBOlcau
         ki/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JRLyNxpw7AvNmeQZzP4O/C4kwoZ5qKtRHpUpLuw/LXw=;
        b=ZZMImL2IaFq3YZZfZa9NUdf5wHZYvezaR0cXoKZWTAjld2lLbqcet3j1J2KQTb7v/E
         3ko9TJWEoE3jPJtAEtlw9FgEzqb+1lk1Ly9/hTwdaoSpbmUkm66j6Xpwl62sh3sB1iAJ
         dsKGg/CcK2rf1kYbNniggbkw2/A0300Zgn/xkyf5v/vG9TaHTcyz7RIw9aQZ92sPezR7
         wmQVg/rMjeo+tA99feJMq6i81Q4vmPs0vRaaFKy4KIeYtKAaYXHlyP3mVdg721jiNZVi
         LzMAEWbdGlUJx0AGbKdh2HQOhAoyWbM7xS7SzOWkm33qegWBzUimUB2n78i/DYAnuT6j
         JGMw==
X-Gm-Message-State: APjAAAVnzEinyYtakFCQJ5XzFuxI7u/dOj2ybQY/dIWMWmC98b2GSXp3
        5zulhNV2IqWn7PSQfa27s4k=
X-Google-Smtp-Source: APXvYqzEWzWJUMNLvQ6+S8sWbhjg2nV967ygfRyLitklsCkf3kyvzCu94zVsSTsQQfaKkmRhLSsxbg==
X-Received: by 2002:a62:4d04:: with SMTP id a4mr95782724pfb.177.1560477418626;
        Thu, 13 Jun 2019 18:56:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id i25sm907740pfr.73.2019.06.13.18.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:58 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH 09/10] blkcg: add tools/cgroup/monitor_ioweight.py
Date:   Thu, 13 Jun 2019 18:56:19 -0700
Message-Id: <20190614015620.1587672-10-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Instead of mucking with debugfs and ->pd_stat(), add drgn based
monitoring script.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/blk-ioweight.c             |  21 +++
 tools/cgroup/monitor_ioweight.py | 264 +++++++++++++++++++++++++++++++
 2 files changed, 285 insertions(+)
 create mode 100644 tools/cgroup/monitor_ioweight.py

diff --git a/block/blk-ioweight.c b/block/blk-ioweight.c
index d10249f5774e..3d9fc1a631be 100644
--- a/block/blk-ioweight.c
+++ b/block/blk-ioweight.c
@@ -146,6 +146,27 @@
  * donate and should take back how much requires hweight propagations
  * anyway making it easier to implement and understand as a separate
  * mechanism.
+ *
+ * 3. Monitoring
+ *
+ * Instead of debugfs or other clumsy monitoring mechanisms, this
+ * controller uses a drgn based monitoring script -
+ * tools/cgroup/monitor_ioweight.py.  For details on drgn, please see
+ * https://github.com/osandov/drgn.  The ouput looks like the following.
+ *
+ *  sdb RUN   per=300ms cur_per=234.218:v203.695 busy= +1 vrate= 62.12%
+ *                 active      weight      hweight% inflt% del_ms usages%
+ *  test/a              *    50/   50  33.33/ 33.33  27.65  0*041 033:033:033
+ *  test/b              *   100/  100  66.67/ 66.67  17.56  0*000 066:079:077
+ *
+ * - per	: Timer period
+ * - cur_per	: Internal wall and device vtime clock
+ * - vrate	: Device virtual time rate against wall clock
+ * - weight	: Surplus-adjusted and configured weights
+ * - hweight	: Surplus-adjusted and configured hierarchical weights
+ * - inflt	: The percentage of in-flight IO cost at the end of last period
+ * - del_ms	: Deferred issuer delay induction level and duration
+ * - usages	: Usage history
  */
 
 #include <linux/kernel.h>
diff --git a/tools/cgroup/monitor_ioweight.py b/tools/cgroup/monitor_ioweight.py
new file mode 100644
index 000000000000..3cd432772e52
--- /dev/null
+++ b/tools/cgroup/monitor_ioweight.py
@@ -0,0 +1,264 @@
+#!/usr/bin/env -S drgn -k
+#
+# This is a drgn script to monitor the blk-ioweight cgroup controller.
+# See the comment at the top of block/blk-ioweight.c for more details.
+# For drgn, visit https://github.com/osandov/drgn.
+#
+
+import sys
+import re
+import time
+import json
+
+import drgn
+from drgn import container_of
+from drgn.helpers.linux.list import list_for_each_entry,list_empty
+from drgn.helpers.linux.radixtree import radix_tree_for_each,radix_tree_lookup
+
+import argparse
+parser = argparse.ArgumentParser()
+parser.add_argument('devname', metavar='DEV',
+                    help='Target block device name (e.g. sda)')
+parser.add_argument('--cgroup', action='append', metavar='REGEX',
+                    help='Regex for target cgroups, ')
+parser.add_argument('--interval', '-i', metavar='SECONDS', type=float, default=1,
+                    help='Monitoring interval in seconds')
+parser.add_argument('--json', action='store_true',
+                    help='Output in json')
+args = parser.parse_args()
+
+def err(s):
+    print(s, file=sys.stderr, flush=True)
+    sys.exit(1)
+
+try:
+    blkcg_root = prog['blkcg_root']
+    plid = prog['blkcg_policy_iow'].plid.value_()
+except:
+    err('The kernel does not have ioweight enabled')
+
+IOW_RUNNING     = prog['IOW_RUNNING'].value_()
+NR_USAGE_SLOTS  = prog['NR_USAGE_SLOTS'].value_()
+HWEIGHT_WHOLE   = prog['HWEIGHT_WHOLE'].value_()
+VTIME_PER_SEC   = prog['VTIME_PER_SEC'].value_()
+VTIME_PER_USEC  = prog['VTIME_PER_USEC'].value_()
+AUTOP_SSD_FAST  = prog['AUTOP_SSD_FAST'].value_()
+AUTOP_SSD_DFL   = prog['AUTOP_SSD_DFL'].value_()
+AUTOP_SSD_QD1   = prog['AUTOP_SSD_QD1'].value_()
+AUTOP_HDD       = prog['AUTOP_HDD'].value_()
+
+autop_names = {
+    AUTOP_SSD_FAST:        'ssd_fast',
+    AUTOP_SSD_DFL:         'ssd_dfl',
+    AUTOP_SSD_QD1:         'ssd_qd1',
+    AUTOP_HDD:             'hdd',
+}
+
+class BlkgIterator:
+    def blkcg_name(blkcg):
+        return blkcg.css.cgroup.kn.name.string_().decode('utf-8')
+
+    def walk(self, blkcg, q_id, parent_path):
+        if not self.include_dying and \
+           not (blkcg.css.flags.value_() & prog['CSS_ONLINE'].value_()):
+            return
+
+        name = BlkgIterator.blkcg_name(blkcg)
+        path = parent_path + '/' + name if parent_path else name
+        blkg = drgn.Object(prog, 'struct blkcg_gq',
+                           address=radix_tree_lookup(blkcg.blkg_tree, q_id))
+        if not blkg.address_:
+            return
+
+        self.blkgs.append((path if path else '/', blkg))
+
+        for c in list_for_each_entry('struct blkcg',
+                                     blkcg.css.children.address_of_(), 'css.sibling'):
+            self.walk(c, q_id, path)
+
+    def __init__(self, root_blkcg, q_id, include_dying=False):
+        self.include_dying = include_dying
+        self.blkgs = []
+        self.walk(root_blkcg, q_id, '')
+
+    def __iter__(self):
+        return iter(self.blkgs)
+
+class IowStat:
+    def __init__(self, iow):
+        global autop_names
+
+        self.enabled = iow.enabled.value_()
+        self.running = iow.running.value_() == IOW_RUNNING
+        self.period_ms = round(iow.period_us.value_() / 1_000)
+        self.period_at = iow.period_at.value_() / 1_000_000
+        self.vperiod_at = iow.period_at_vtime.value_() / VTIME_PER_SEC
+        self.vrate_pct = iow.vtime_rate.counter.value_() * 100 / VTIME_PER_USEC
+        self.busy_level = iow.busy_level.value_()
+        self.autop_idx = iow.autop_idx.value_()
+        self.user_cost_model = iow.user_cost_model.value_()
+        self.user_qos_params = iow.user_qos_params.value_()
+
+        if self.autop_idx in autop_names:
+            self.autop_name = autop_names[self.autop_idx]
+        else:
+            self.autop_name = '?'
+
+    def dict(self, now):
+        return { 'device'               : devname,
+                 'timestamp'            : now,
+                 'enabled'              : self.enabled,
+                 'running'              : self.running,
+                 'period_ms'            : self.period_ms,
+                 'period_at'            : self.period_at,
+                 'period_vtime_at'      : self.vperiod_at,
+                 'busy_level'           : self.busy_level,
+                 'vrate_pct'            : self.vrate_pct, }
+
+    def table_preamble_str(self):
+        state = ('RUN' if self.running else 'IDLE') if self.enabled else 'OFF'
+        output = f'{devname} {state:4} ' \
+                 f'per={self.period_ms}ms ' \
+                 f'cur_per={self.period_at:.3f}:v{self.vperiod_at:.3f} ' \
+                 f'busy={self.busy_level:+3} ' \
+                 f'vrate={self.vrate_pct:6.2f}% ' \
+                 f'params={self.autop_name}'
+        if self.user_cost_model or self.user_qos_params:
+            output += f'({"C" if self.user_cost_model else ""}{"Q" if self.user_qos_params else ""})'
+        return output
+
+    def table_header_str(self):
+        return f'{"":25} active {"weight":>9} {"hweight%":>13} {"inflt%":>6} ' \
+               f'{"del_ms":>6} {"usages%"}'
+
+class IowgStat:
+    def __init__(self, iowg):
+        iow = iowg.iow
+        blkg = iowg.pd.blkg
+
+        self.is_active = not list_empty(iowg.active_list.address_of_())
+        self.weight = iowg.weight.value_()
+        self.active = iowg.active.value_()
+        self.inuse = iowg.inuse.value_()
+        self.hwa_pct = iowg.hweight_active.value_() * 100 / HWEIGHT_WHOLE
+        self.hwi_pct = iowg.hweight_inuse.value_() * 100 / HWEIGHT_WHOLE
+
+        vdone = iowg.done_vtime.counter.value_()
+        vtime = iowg.vtime.counter.value_()
+        vrate = iow.vtime_rate.counter.value_()
+        period_vtime = iow.period_us.value_() * vrate
+        if period_vtime:
+            self.inflight_pct = (vtime - vdone) * 100 / period_vtime
+        else:
+            self.inflight_pct = 0
+
+        self.use_delay = min(blkg.use_delay.counter.value_(), 99)
+        self.delay_ms = min(round(blkg.delay_nsec.counter.value_() / 1_000_000), 999)
+
+        usage_idx = iowg.usage_idx.value_()
+        self.usages = []
+        self.usage = 0
+        for i in range(NR_USAGE_SLOTS):
+            usage = iowg.usages[(usage_idx + i) % NR_USAGE_SLOTS].value_()
+            upct = min(usage * 100 / HWEIGHT_WHOLE, 999)
+            self.usages.append(upct)
+            self.usage = max(self.usage, upct)
+
+    def dict(self, now, path):
+        out = { 'cgroup'                : path,
+                'timestamp'             : now,
+                'is_active'             : self.is_active,
+                'weight'                : self.weight,
+                'weight_active'         : self.active,
+                'weight_inuse'          : self.inuse,
+                'hweight_active_pct'    : self.hwa_pct,
+                'hweight_inuse_pct'     : self.hwi_pct,
+                'inflight_pct'          : self.inflight_pct,
+                'use_delay'             : self.use_delay,
+                'delay_ms'              : self.delay_ms,
+                'usage_pct'             : self.usage }
+        for i in range(len(self.usages)):
+            out[f'usage_pct_{i}'] = f'{self.usages[i]}'
+        return out
+
+    def table_row_str(self, path):
+        out = f'{path[-28:]:28} ' \
+              f'{"*" if self.is_active else " "} ' \
+              f'{self.inuse:5}/{self.active:5} ' \
+              f'{self.hwi_pct:6.2f}/{self.hwa_pct:6.2f} ' \
+              f'{self.inflight_pct:6.2f} ' \
+              f'{self.use_delay:2}*{self.delay_ms:03} '
+        for u in self.usages:
+            out += f'{round(u):03d}:'
+        out = out.rstrip(':')
+        return out
+
+# handle args
+table_fmt = not args.json
+interval = args.interval
+devname = args.devname
+
+if args.json:
+    table_fmt = False
+
+re_str = None
+for r in args.cgroup:
+    if re_str is None:
+        re_str = r
+    else:
+        re_str += '|' + r
+
+filter_re = re.compile(re_str) if re_str else None
+
+# Locate the roots
+q_id = None
+root_iowg = None
+iow = None
+
+for i, ptr in radix_tree_for_each(blkcg_root.blkg_tree):
+    blkg = drgn.Object(prog, 'struct blkcg_gq', address=ptr)
+    try:
+        if devname == blkg.q.kobj.parent.name.string_().decode('utf-8'):
+            q_id = blkg.q.id.value_()
+            if blkg.pd[plid]:
+                root_iowg = container_of(blkg.pd[plid], 'struct iow_gq', 'pd')
+                iow = root_iowg.iow
+            break
+    except:
+        pass
+
+if iow is None:
+    err(f'Could not find iow for {devname}');
+
+# Keep printing
+while True:
+    now = time.time()
+    iowstat = IowStat(iow)
+    output = ''
+
+    if table_fmt:
+        output += '\n' + iowstat.table_preamble_str()
+        output += '\n' + iowstat.table_header_str()
+    else:
+        output += json.dumps(iowstat.dict(now))
+
+    for path, blkg in BlkgIterator(blkcg_root, q_id):
+        if filter_re and not filter_re.match(path):
+            continue
+        if not blkg.pd[plid]:
+            continue
+
+        iowg = container_of(blkg.pd[plid], 'struct iow_gq', 'pd')
+        iowg_stat = IowgStat(iowg)
+
+        if not filter_re and not iowg_stat.is_active:
+            continue
+
+        if table_fmt:
+            output += '\n' + iowg_stat.table_row_str(path)
+        else:
+            output += '\n' + json.dumps(iowg_stat.dict(now, path))
+
+    print(output)
+    sys.stdout.flush()
+    time.sleep(interval)
-- 
2.17.1

