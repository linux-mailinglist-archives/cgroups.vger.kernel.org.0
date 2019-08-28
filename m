Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A509A0D44
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfH1WGr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44258 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfH1WG0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so1352708qtg.11;
        Wed, 28 Aug 2019 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTmjeJb8iUEUofnVcMj/ipLT+t1T3/xUlVFZHBWwEns=;
        b=BqCjjelmwZ1phoBX2LjjySinujpZy0jSFpOMtyn/ogKUnBZ8mn7D0YkG36e7tYu4Qo
         V/qBtOTQbe+dzfDVAK5NjQ0e5zep2Ong//miVsrbsy4IgGVT6n9xjNMyXZ58uEFoWeBl
         KO9P6YCigIeZWdBvEZB+c09GnlSa5djgN7Mtt45j/jtc2jF+VO0zKvIfB0sRpUhcAbqO
         SoVgP/QjmyjbG25cNhG7E+xFCo5/EGmJCail+cdiyx4i1/9VCN5QNrhr8YPxp8AXhZ0C
         dwmt4XiIh6ihCF+Wo6FxUhTfQcRAahXs9uEZ8QTEMQ7PHHVfgX7MoUZ+lwDnHN+dSI8O
         UrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dTmjeJb8iUEUofnVcMj/ipLT+t1T3/xUlVFZHBWwEns=;
        b=rS4mF+epUvxNxZ7dYdW8hu4BSqt/ZIuiUBCxqks4DXl7RMMMhvEiB9ekujD+2uGoA+
         pwC5E8PC0W4+zBzrKMeeYUXah0xbZoEnU38U8vDX7MCWp5BtpoKkmLOP0HrzodJURirM
         u12U63aJ5nDiTssMV3k4cFehfETbZj2L8Tc2DqfIK8zHOF7QAfXk+yMAivpmRjDT0qgj
         eWUS3RNNxeYakPe91X9/AmzXoQv5Fiun8AcXqYODFwKTwZV0AkvZXQ0HBYLAp6pBwdBY
         PsjqpeoptF5Gl1+CC28EEJBf5/xGMdtDpOHWLnGtpF24fCJO5U2axIXpEKg7XTCDvUZw
         eBvA==
X-Gm-Message-State: APjAAAXI9NXdTBnmOM5dxct2T5jeNWaK7kF54a1bSneVusHcZdRnzvnU
        dHaNQDd5DkfshPEM+q3wGjU=
X-Google-Smtp-Source: APXvYqwBcGVRz2vji6hXxr5w+lpqVF+OFFRXRzZtVNtGO4jNsT8kl0I1MhKtq6l0Vx5WWyyQ9blUog==
X-Received: by 2002:aed:22d5:: with SMTP id q21mr6688474qtc.199.1567029985597;
        Wed, 28 Aug 2019 15:06:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id h4sm212215qkf.126.2019.08.28.15.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:24 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 09/10] blkcg: add tools/cgroup/iocost_monitor.py
Date:   Wed, 28 Aug 2019 15:05:59 -0700
Message-Id: <20190828220600.2527417-10-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
References: <20190828220600.2527417-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Instead of mucking with debugfs and ->pd_stat(), add drgn based
monitoring script.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/blk-iocost.c             |  21 +++
 tools/cgroup/iocost_monitor.py | 270 +++++++++++++++++++++++++++++++++
 2 files changed, 291 insertions(+)
 create mode 100644 tools/cgroup/iocost_monitor.py

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 680815620095..3208d2fdc55e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -149,6 +149,27 @@
  * donate and should take back how much requires hweight propagations
  * anyway making it easier to implement and understand as a separate
  * mechanism.
+ *
+ * 3. Monitoring
+ *
+ * Instead of debugfs or other clumsy monitoring mechanisms, this
+ * controller uses a drgn based monitoring script -
+ * tools/cgroup/iocost_monitor.py.  For details on drgn, please see
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
diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
new file mode 100644
index 000000000000..2c9445e966d8
--- /dev/null
+++ b/tools/cgroup/iocost_monitor.py
@@ -0,0 +1,270 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2019 Tejun Heo <tj@kernel.org>
+# Copyright (C) 2019 Facebook
+
+desc = """
+This is a drgn script to monitor the blk-iocost cgroup controller.
+See the comment at the top of block/blk-iocost.c for more details.
+For drgn, visit https://github.com/osandov/drgn.
+"""
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
+parser = argparse.ArgumentParser(description=desc,
+                                 formatter_class=argparse.RawTextHelpFormatter)
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
+    plid = prog['blkcg_policy_iocost'].plid.value_()
+except:
+    err('The kernel does not have iocost enabled')
+
+IOC_RUNNING     = prog['IOC_RUNNING'].value_()
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
+class IocStat:
+    def __init__(self, ioc):
+        global autop_names
+
+        self.enabled = ioc.enabled.value_()
+        self.running = ioc.running.value_() == IOC_RUNNING
+        self.period_ms = round(ioc.period_us.value_() / 1_000)
+        self.period_at = ioc.period_at.value_() / 1_000_000
+        self.vperiod_at = ioc.period_at_vtime.value_() / VTIME_PER_SEC
+        self.vrate_pct = ioc.vtime_rate.counter.value_() * 100 / VTIME_PER_USEC
+        self.busy_level = ioc.busy_level.value_()
+        self.autop_idx = ioc.autop_idx.value_()
+        self.user_cost_model = ioc.user_cost_model.value_()
+        self.user_qos_params = ioc.user_qos_params.value_()
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
+class IocgStat:
+    def __init__(self, iocg):
+        ioc = iocg.ioc
+        blkg = iocg.pd.blkg
+
+        self.is_active = not list_empty(iocg.active_list.address_of_())
+        self.weight = iocg.weight.value_()
+        self.active = iocg.active.value_()
+        self.inuse = iocg.inuse.value_()
+        self.hwa_pct = iocg.hweight_active.value_() * 100 / HWEIGHT_WHOLE
+        self.hwi_pct = iocg.hweight_inuse.value_() * 100 / HWEIGHT_WHOLE
+
+        vdone = iocg.done_vtime.counter.value_()
+        vtime = iocg.vtime.counter.value_()
+        vrate = ioc.vtime_rate.counter.value_()
+        period_vtime = ioc.period_us.value_() * vrate
+        if period_vtime:
+            self.inflight_pct = (vtime - vdone) * 100 / period_vtime
+        else:
+            self.inflight_pct = 0
+
+        self.use_delay = min(blkg.use_delay.counter.value_(), 99)
+        self.delay_ms = min(round(blkg.delay_nsec.counter.value_() / 1_000_000), 999)
+
+        usage_idx = iocg.usage_idx.value_()
+        self.usages = []
+        self.usage = 0
+        for i in range(NR_USAGE_SLOTS):
+            usage = iocg.usages[(usage_idx + i) % NR_USAGE_SLOTS].value_()
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
+if args.cgroup:
+    for r in args.cgroup:
+        if re_str is None:
+            re_str = r
+        else:
+            re_str += '|' + r
+
+filter_re = re.compile(re_str) if re_str else None
+
+# Locate the roots
+q_id = None
+root_iocg = None
+ioc = None
+
+for i, ptr in radix_tree_for_each(blkcg_root.blkg_tree):
+    blkg = drgn.Object(prog, 'struct blkcg_gq', address=ptr)
+    try:
+        if devname == blkg.q.kobj.parent.name.string_().decode('utf-8'):
+            q_id = blkg.q.id.value_()
+            if blkg.pd[plid]:
+                root_iocg = container_of(blkg.pd[plid], 'struct ioc_gq', 'pd')
+                ioc = root_iocg.ioc
+            break
+    except:
+        pass
+
+if ioc is None:
+    err(f'Could not find ioc for {devname}');
+
+# Keep printing
+while True:
+    now = time.time()
+    iocstat = IocStat(ioc)
+    output = ''
+
+    if table_fmt:
+        output += '\n' + iocstat.table_preamble_str()
+        output += '\n' + iocstat.table_header_str()
+    else:
+        output += json.dumps(iocstat.dict(now))
+
+    for path, blkg in BlkgIterator(blkcg_root, q_id):
+        if filter_re and not filter_re.match(path):
+            continue
+        if not blkg.pd[plid]:
+            continue
+
+        iocg = container_of(blkg.pd[plid], 'struct ioc_gq', 'pd')
+        iocg_stat = IocgStat(iocg)
+
+        if not filter_re and not iocg_stat.is_active:
+            continue
+
+        if table_fmt:
+            output += '\n' + iocg_stat.table_row_str(path)
+        else:
+            output += '\n' + json.dumps(iocg_stat.dict(now, path))
+
+    print(output)
+    sys.stdout.flush()
+    time.sleep(interval)
-- 
2.17.1

