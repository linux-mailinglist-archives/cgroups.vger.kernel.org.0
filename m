Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9CC719E9
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2019 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfGWOF0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 10:05:26 -0400
Received: from mail.univention.de ([82.198.197.8]:29615 "EHLO
        mail.univention.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfGWOF0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 10:05:26 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jul 2019 10:05:25 EDT
Received: from localhost (localhost [127.0.0.1])
        by solig.knut.univention.de (Postfix) with ESMTP id 5761367FBCF9;
        Tue, 23 Jul 2019 15:57:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.10.1 (20141025) (Debian) at
        knut.univention.de
Received: from mail.univention.de ([127.0.0.1])
        by localhost (solig.knut.univention.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NPOy2s2nKK_H; Tue, 23 Jul 2019 15:56:59 +0200 (CEST)
Received: from [192.168.0.222] (mail.univention.de [82.198.197.8])
        by solig.knut.univention.de (Postfix) with ESMTPSA id 1E82E67FBCED;
        Tue, 23 Jul 2019 15:56:59 +0200 (CEST)
To:     cgroups@vger.kernel.org, systemd-devel@lists.freedesktop.org
From:   Philipp Hahn <hahn@univention.de>
Subject: linux-image-4.9.0-9: Memory "leak" caused by CGroup as used by
 pam_systemd
Openpgp: preference=signencrypt
Autocrypt: addr=hahn@univention.de; prefer-encrypt=mutual; keydata=
 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
 E57YS6NHln5zGC8hHrOFsw==
Organization: Univention GmbH
Cc:     Roman Gushchin <guro@fb.com>,
        =?UTF-8?B?5q6154aK5pil?= <duanxiongchun@bytedance.com>
Message-ID: <ad0222ca-5fb0-4177-dc82-ca63f079e942@univention.de>
Date:   Tue, 23 Jul 2019 15:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------96D375F0260231941D7A2A1D"
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a multi-part message in MIME format.
--------------96D375F0260231941D7A2A1D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

I analyzed the issue and the problem seems to be CGroup related:

- we're using 'pam_systemd' in "/etc/pam.d/common-session"

- each cron-job / login then creates a new CGroup below
"/sys/fs/cgroup/systemd/user.slice/" while that job / session is running

- when the job / session terminates, the directory is deleted by
pam_systemd.

- but the Linux kernel still uses the CGroup to track kernel internal
memory (SLAB objects, pending cache pages, ...?)

- inside the kernel the CGroup is marked as "dying", but it is only
garbage collected very later on

- until then it adds to memory pressure and very slowly pushed the
system into swap.


I back-ported the patch
<https://www.spinics.net/lists/cgroups/msg20611.html> from Roman
Gushchin to add some extra debugging, which indeed shows a large number
of "dying" cgroups:

> # find /sys/fs/cgroup/memory -name cgroup.stat -exec grep '^nr_dying_descendants [^0]'  {} +
>   /sys/fs/cgroup/memory/cgroup.stat:nr_dying_descendants 360
>   /sys/fs/cgroup/memory/user.slice/cgroup.stat:nr_dying_descendants 320
>   /sys/fs/cgroup/memory/user.slice/user-0.slice/cgroup.stat:nr_dying_descendants 303
>   /sys/fs/cgroup/memory/system.slice/cgroup.stat:nr_dying_descendants 40
> # grep ^memory /proc/cgroups 
>   memory  10      452     1

Removing "pam_systemd" from PAM makes the problem go away.

Later Debain kernels are compiled with "CONFIG_MEMCG_KMEM=y", which
prompted me to add "cgroup.memory=nokmem" to the kernel command line.
This also seems to reduce the problem, but I'm not 100% convinced that
it really improves the situation.


I do not have a very good reproducer, but creating a cron-job with just
> * * *  * *  root  dd if=/dev/urandom of=/var/tmp/test-$$ count=1 >/dev/null

will most often increase the number of dying CGs every minute by one.


I do not know who is at fault here, if it is
- the Linux kernel for not freeing those resources earlier
- systemd for using CGs in a broken way
- someone others fault.

Clearly this is not good and I would like to receive some feedback on
what could be done top solve this issue, as running cron jobs is user
exploitable and can be used to DoS the system.
While looking for existing bug reports I stumbled over 912411 in Debian,
which also claims that there is a CG related leak - with Linux 4.19.x.

Should "pam_systemd" maybe do something like this before deleting the CG
directory:
> echo 0 >/sys/fs/cgroup/memory/.../memory.force_empty


Some more details are available at our bug-tracker at
<https://forge.univention.org/bugzilla/show_bug.cgi?id=49614#c5>.

Debian-Bugs:
* <https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=931111>
* <https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=912411>

Sincerely
Philipp
-- 
Philipp Hahn
Open Source Software Engineer

Univention GmbH
be open.
Mary-Somerville-Str. 1
D-28359 Bremen
Tel.: +49 421 22232-0
Fax : +49 421 22232-99
hahn@univention.de

https://www.univention.de/
Geschäftsführer: Peter H. Ganten
HRB 20755 Amtsgericht Bremen
Steuer-Nr.: 71-597-02876

--------------96D375F0260231941D7A2A1D
Content-Type: text/x-patch;
 name="49614_linux-cgroup-dying.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="49614_linux-cgroup-dying.diff"

=46rom 0679dee03c6d706d57145ea92c23d08fa10a1999 Mon Sep 17 00:00:00 2001
Message-Id: <0679dee03c6d706d57145ea92c23d08fa10a1999.1562083574.git.hahn=
@univention.de>
From: Roman Gushchin <guro@fb.com>
Date: Wed, 2 Aug 2017 17:55:29 +0100
Subject: [PATCH] cgroup: keep track of number of descent cgroups

Keep track of the number of online and dying descent cgroups.

This data will be used later to add an ability to control cgroup
hierarchy (limit the depth and the number of descent cgroups)
and display hierarchy stats.

Signed-off-by: Roman Gushchin <guro@fb.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan@huawei.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: kernel-team@fb.com
Cc: cgroups@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <hahn@univention.de>
Url: https://www.spinics.net/lists/cgroups/msg20611.html
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -4922,6 +4922,18 @@ static struct cftype cgroup_dfl_base_fil
 	{ }	/* terminate */
 };
=20
+static int cgroup_stat_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgroup =3D seq_css(seq)->cgroup;
+
+	seq_printf(seq, "nr_descendants %d\n",
+		   cgroup->nr_descendants);
+	seq_printf(seq, "nr_dying_descendants %d\n",
+		   cgroup->nr_dying_descendants);
+
+	return 0;
+}
+
 /* cgroup core interface files for the legacy hierarchies */
 static struct cftype cgroup_legacy_base_files[] =3D {
 	{
@@ -4964,6 +4976,10 @@ static struct cftype cgroup_legacy_base_
 		.write =3D cgroup_release_agent_write,
 		.max_write_len =3D PATH_MAX - 1,
 	},
+	{
+		.name =3D "cgroup.stat",
+		.seq_show =3D cgroup_stat_show,
+	},
 	{ }	/* terminate */
 };
=20
@@ -5063,9 +5079,15 @@ static void css_release_work_fn(struct w
 		if (ss->css_released)
 			ss->css_released(css);
 	} else {
+		struct cgroup *tcgrp;
+
 		/* cgroup release path */
 		trace_cgroup_release(cgrp);
=20
+		for (tcgrp =3D cgroup_parent(cgrp); tcgrp;
+		     tcgrp =3D cgroup_parent(tcgrp))
+			tcgrp->nr_dying_descendants--;
+
 		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
 		cgrp->id =3D -1;
=20
@@ -5262,9 +5284,13 @@ static struct cgroup *cgroup_create(stru
 	cgrp->root =3D root;
 	cgrp->level =3D level;
=20
-	for (tcgrp =3D cgrp; tcgrp; tcgrp =3D cgroup_parent(tcgrp))
+	for (tcgrp =3D cgrp; tcgrp; tcgrp =3D cgroup_parent(tcgrp)) {
 		cgrp->ancestor_ids[tcgrp->level] =3D tcgrp->id;
=20
+		if (tcgrp !=3D cgrp)
+			tcgrp->nr_descendants++;
+	}
+
 	if (notify_on_release(parent))
 		set_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
=20
@@ -5468,6 +5494,7 @@ static void kill_css(struct cgroup_subsy
 static int cgroup_destroy_locked(struct cgroup *cgrp)
 	__releases(&cgroup_mutex) __acquires(&cgroup_mutex)
 {
+	struct cgroup *tcgrp;
 	struct cgroup_subsys_state *css;
 	struct cgrp_cset_link *link;
 	int ssid;
@@ -5512,6 +5539,11 @@ static int cgroup_destroy_locked(struct
 	 */
 	kernfs_remove(cgrp->kn);
=20
+	for (tcgrp =3D cgroup_parent(cgrp); tcgrp; tcgrp =3D cgroup_parent(tcgr=
p)) {
+		tcgrp->nr_descendants--;
+		tcgrp->nr_dying_descendants++;
+	}
+
 	check_for_release(cgroup_parent(cgrp));
=20
 	/* put the base reference */
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -245,6 +245,14 @@ struct cgroup {
 	int level;
=20
 	/*
+	 * Keep track of total numbers of visible and dying descent cgroups.
+	 * Dying cgroups are cgroups which were deleted by a user,
+	 * but are still existing because someone else is holding a reference.
+	 */
+	int nr_descendants;
+	int nr_dying_descendants;
+
+	/*
 	 * Each non-empty css_set associated with this cgroup contributes
 	 * one to populated_cnt.  All children with non-zero popuplated_cnt
 	 * of their own contribute one.  The count is zero iff there's no

--------------96D375F0260231941D7A2A1D--
