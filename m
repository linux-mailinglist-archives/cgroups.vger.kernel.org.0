Return-Path: <cgroups+bounces-8460-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1645AD1197
	for <lists+cgroups@lfdr.de>; Sun,  8 Jun 2025 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261FD188AFB6
	for <lists+cgroups@lfdr.de>; Sun,  8 Jun 2025 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499AF13C3CD;
	Sun,  8 Jun 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff0sg7UB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9D1DE2C9;
	Sun,  8 Jun 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749372784; cv=none; b=uKYYTZMKv3cZSczv85yu5pD5oG/Oq0wfZa8WGRYVwlQBLN4n3PRqTXXdGQoURxRr32dhxtXNO5nqS+M1grJnpN0xtpORtDzgLx9LCDo4VD8SJuC6IdFzpW30uWNP8vCFogRYftoVQdxbHumhWctahA7uyo4ixgkhNW0OezwJbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749372784; c=relaxed/simple;
	bh=IURka8PIWHXyzmvJRrOYnPeA8lb/KRRi53oneAZE6Y4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TkeTMUKyh/NHUzIIn5DE2tw9DK7TAMahhU+m7QmKT9o1i5v4x5AeLh3ukDzPxPVRPjMUiAPnZzD7iKODOrNfsR/yrTCpbpaGZs4ig1VuMCk075d07Gqu7odX3BgXSB8x7H+eAFL2tyAd8Q+JMfSjcwwg/gd3U7Cs3pYzDH0dtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff0sg7UB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313132d1f7aso2596616a91.3;
        Sun, 08 Jun 2025 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749372781; x=1749977581; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avdQMIlThhCh5I5aJXPZj1sqS0yK8djyk+mRbHuq5Ic=;
        b=Ff0sg7UBSwoZcLHxsu+WrKdHeo11iLzfUy9ZubGlxzHZZcbqjsrjGGssDN3pGpUSO/
         8I/C/DFxB1x1Z94eBITZjSZetvGORv44EkgFA2AJsE/hO+py0rMzEG67whiDmsMuY2Ju
         xdAdA9BWhpMtzSY4Uz4WIiLZhk4+oNFjU8Eo0X9ERwyz2NlPrxX50RoaLOLhJk3VXxMT
         /TRlbb4zip56t1scK415IUpjdyYAuqnQ5GNaUIZPG1vfOGJGhlnA5Ku2jeb4uQaB08iW
         lkm7YJv4DwvtnN/uARoyVF3i1jTgjvczytiwamlgFfkSwhqyP1ycCQ1h9GowqQ+amac1
         EOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749372781; x=1749977581;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avdQMIlThhCh5I5aJXPZj1sqS0yK8djyk+mRbHuq5Ic=;
        b=b2ZNlvlWbAXtaL7Yh+MVTG6EDI6Z3IjiCilMt5sAPNWEsMDqi2tsbm6fgd5nqJWy34
         tZtbzBg5KHMKG30Zri3GB52mXbRevn/zoajG/O0TkHMX4pj011+lEV36yxulHR3MtyFS
         2IurKh8VZf2AKV4rJ/+SLjYE0I/wnfQKjtt/yA00PGogNR38aTKlxaZCK1ujs8Pw/XWr
         EGZkR0FcoKWaEp+8ytA/JtASl6EZDhCee8+pHZ5NT5SQN9JXFHfOp4JChlwP3sQoep1y
         ooIM6Q6qouLarTb4zLUPbslwcPNTJZF6yYTh22MP6yzwLxS1a3NnwaMUdsB+FNLToDvm
         18ag==
X-Forwarded-Encrypted: i=1; AJvYcCUH/jfIuK2jxrz92Xs1dxU4Xdrc/rr1BgxLVV042d651lk5a/YD65VW43HcvbtVRL1bE1ay4dMA@vger.kernel.org, AJvYcCWmHQuL2jfeEa+/cTbID41HkwSzSeL3ikkWmSZsGJ7VRhz6St1zxsgzh9QflReN/pfvuuohwvL449PaTJBE@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOhRfXFDxJIUAwyPJq6w2z5EyGMM22KSLBS6wCYqkWxfxBpcy
	3HswAdXnhMm4M3RQ0ow5NdAIbhsjThBpfUTH7KGw6IEYCIDtyo7hFEGl
X-Gm-Gg: ASbGncuKQBHUhv3nhs7UO4FJB32ITa9ScuOqXaWOrCNbCwn8sDiJwMr+0R1xsBAUOXn
	h+TwzVuFOdx0+dOZRuARGzzXQMQXjlPXACQZSxp2/0u+lhaEYFxAMuU7EKWK24u0b7gM9dNK91I
	3sRH+5/c+O+jdFVJaZTvzKsYaytI+FS7/Q2o5LXY+XkexFVIOCwkMAd5I5UAJvPg9S6OOBqRk8D
	piPBgAzdIZshkAfp3BCkcYRjX6hphu/gOnsaH1Ni5cgNkQ75Lj3pn+TTL+hcU9H3dNhH+BUPqrh
	vg78TebJzn90hsQf7jzX1s2qTpRSHKK+X3Km5c9SgrZYBE+H+99etd5ykGC7gkXhcNjEHYzD
X-Google-Smtp-Source: AGHT+IH3yukOeEjm/597ooOmzsx1Zyoag4XjUjLJPh3zqnZ/Oo0K5xrOEJtjVGRsrKAgpyrvFKz2jg==
X-Received: by 2002:a17:90b:4fd2:b0:311:2f5:6b1 with SMTP id 98e67ed59e1d1-31346f5af24mr10914709a91.22.1749372781425;
        Sun, 08 Jun 2025 01:53:01 -0700 (PDT)
Received: from smtpclient.apple ([202.8.105.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034059cbsm36546095ad.165.2025.06.08.01.52.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jun 2025 01:53:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v1 3/3] cgroup: add lock guard support for others
From: Jemmy Wong <jemmywong512@gmail.com>
In-Reply-To: <202506071822.ERv4i34r-lkp@intel.com>
Date: Sun, 8 Jun 2025 16:52:46 +0800
Cc: Jemmy <jemmywong512@gmail.com>,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 oe-kbuild-all@lists.linux.dev,
 Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Waiman Long <longman@redhat.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <722C5824-0381-4E43-B8AE-AE8503CFF51E@gmail.com>
References: <20250606161841.44354-4-jemmywong512@gmail.com>
 <202506071822.ERv4i34r-lkp@intel.com>
To: kernel test robot <lkp@intel.com>,
 peterz@infradead.org,
 dan.j.williams@intel.com,
 mingo@kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi Peter, Dam, Ingo,

Do you have any recommendations to eliminate this false positive, given =
that sparse recognizes scoped_guard but not guard?

Looks like false positives. Some of these warnings were already present=20=

due to asymmetric lock/unlock behavior in a specific function,

while others were introduced by the use of guard,=20
which can be resolved by replacing it with scoped_guard,=20
but I don=E2=80=99t like this solution which could add additional =
indentation.

=E2=80=94=E2=80=94

Previous warnings - caused by asymmetric lock/unlock:

kernel/cgroup/cgroup.c:3161:9: sparse: warning: context imbalance in =
'cgroup_lock_and_drain_offline' - wrong count at exit
kernel/cgroup/cgroup.c:6530:12: sparse: warning: context imbalance in =
'cgroup_css_set_fork' - wrong count at exit
kernel/cgroup/cgroup.c:6646:9: sparse: warning: context imbalance in =
'cgroup_css_set_put_fork' - wrong count at exit
kernel/cgroup/cgroup.c:6666:5: sparse: warning: context imbalance in =
'cgroup_can_fork' - wrong count at exit
kernel/cgroup/cgroup.c:6715:9: sparse: warning: context imbalance in =
'cgroup_cancel_fork' - unexpected unlock

New warnings - caused by guard:

kernel/cgroup/cgroup.c:345:13: sparse: sparse: context imbalance in =
'cgroup_idr_replace' - wrong count at exit
kernel/cgroup/cgroup.c:351:13: sparse: sparse: context imbalance in =
'cgroup_idr_remove' - wrong count at exit
kernel/cgroup/cgroup.c:626:5: sparse: sparse: context imbalance in =
'cgroup_task_count' - wrong count at exit
kernel/cgroup/cgroup.c:2225:9: sparse: sparse: context imbalance in =
'cgroup_do_get_tree' - different lock contexts for basic block
kernel/cgroup/cgroup.c:2418:5: sparse: sparse: context imbalance in =
'cgroup_path_ns' - wrong count at exit
kernel/cgroup/cgroup.c:2734:9: sparse: sparse: context imbalance in =
'cgroup_migrate_finish' - wrong count at exit
kernel/cgroup/cgroup.c:4532:9: sparse: sparse: context imbalance in =
'cgroup_file_notify' - wrong count at exit
kernel/cgroup/cgroup.c:4994:9: sparse: sparse: context imbalance in =
'css_task_iter_start' - wrong count at exit
kernel/cgroup/cgroup.c:5027:9: sparse: sparse: context imbalance in =
'css_task_iter_next' - wrong count at exit
kernel/cgroup/cgroup.c:5047:9: sparse: sparse: context imbalance in =
'css_task_iter_end' - wrong count at exit

Best,
Jemmy

> On Jun 7, 2025, at 6:50=E2=80=AFPM, kernel test robot <lkp@intel.com> =
wrote:
>=20
> Hi Jemmy,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on tj-cgroup/for-next]
> [also build test WARNING on linus/master next-20250606]
> [cannot apply to v6.15]
> [If your patch is applied to the wrong git tree, kindly drop us a =
note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    =
https://github.com/intel-lab-lkp/linux/commits/Jemmy-Wong/cgroup-add-lock-=
guard-support-for-cgroup_muetx/20250607-002109
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
for-next
> patch link:    =
https://lore.kernel.org/r/20250606161841.44354-4-jemmywong512%40gmail.com
> patch subject: [PATCH v1 3/3] cgroup: add lock guard support for =
others
> config: sparc-randconfig-r121-20250607 =
(https://download.01.org/0day-ci/archive/20250607/202506071822.ERv4i34r-lk=
p@intel.com/config)
> compiler: sparc-linux-gcc (GCC) 8.5.0
> reproduce: =
(https://download.01.org/0day-ci/archive/20250607/202506071822.ERv4i34r-lk=
p@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202506071822.ERv4i34r-lkp@intel.com/=

>=20
> sparse warnings: (new ones prefixed by >>)
>>> kernel/cgroup/cgroup.c:6721:33: sparse: sparse: incorrect type in =
argument 1 (different address spaces) @@     expected struct spinlock =
[usertype] *l @@     got struct spinlock [noderef] __rcu * @@
>   kernel/cgroup/cgroup.c:6721:33: sparse:     expected struct spinlock =
[usertype] *l
>   kernel/cgroup/cgroup.c:6721:33: sparse:     got struct spinlock =
[noderef] __rcu *
>   kernel/cgroup/cgroup.c:345:13: sparse: sparse: context imbalance in =
'cgroup_idr_replace' - wrong count at exit
>   kernel/cgroup/cgroup.c:351:13: sparse: sparse: context imbalance in =
'cgroup_idr_remove' - wrong count at exit
>   kernel/cgroup/cgroup.c:626:5: sparse: sparse: context imbalance in =
'cgroup_task_count' - wrong count at exit
>   kernel/cgroup/cgroup.c:2225:9: sparse: sparse: context imbalance in =
'cgroup_do_get_tree' - different lock contexts for basic block
>   kernel/cgroup/cgroup.c:2418:5: sparse: sparse: context imbalance in =
'cgroup_path_ns' - wrong count at exit
>   kernel/cgroup/cgroup.c:2734:9: sparse: sparse: context imbalance in =
'cgroup_migrate_finish' - wrong count at exit
>   kernel/cgroup/cgroup.c:3131:9: sparse: sparse: context imbalance in =
'cgroup_lock_and_drain_offline' - wrong count at exit
>   kernel/cgroup/cgroup.c:4532:9: sparse: sparse: context imbalance in =
'cgroup_file_notify' - wrong count at exit
>   kernel/cgroup/cgroup.c:4994:9: sparse: sparse: context imbalance in =
'css_task_iter_start' - wrong count at exit
>   kernel/cgroup/cgroup.c:5027:9: sparse: sparse: context imbalance in =
'css_task_iter_next' - wrong count at exit
>   kernel/cgroup/cgroup.c:5047:9: sparse: sparse: context imbalance in =
'css_task_iter_end' - wrong count at exit
>   kernel/cgroup/cgroup.c:6485:12: sparse: sparse: context imbalance in =
'cgroup_css_set_fork' - wrong count at exit
>   kernel/cgroup/cgroup.c:6601:9: sparse: sparse: context imbalance in =
'cgroup_css_set_put_fork' - wrong count at exit
>   kernel/cgroup/cgroup.c:6621:5: sparse: sparse: context imbalance in =
'cgroup_can_fork' - wrong count at exit
>   kernel/cgroup/cgroup.c:6670:9: sparse: sparse: context imbalance in =
'cgroup_cancel_fork' - unexpected unlock
>   kernel/cgroup/cgroup.c:6813:9: sparse: sparse: context imbalance in =
'cgroup_release' - different lock contexts for basic block
>=20
> vim +6721 kernel/cgroup/cgroup.c
>=20
>  6672=20
>  6673 /**
>  6674 * cgroup_post_fork - finalize cgroup setup for the child process
>  6675 * @child: the child process
>  6676 * @kargs: the arguments passed to create the child process
>  6677 *
>  6678 * Attach the child process to its css_set calling the subsystem =
fork()
>  6679 * callbacks.
>  6680 */
>  6681 void cgroup_post_fork(struct task_struct *child,
>  6682      struct kernel_clone_args *kargs)
>  6683 __releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
>  6684 {
>  6685 unsigned int cgrp_kill_seq =3D 0;
>  6686 unsigned long cgrp_flags =3D 0;
>  6687 bool kill =3D false;
>  6688 struct cgroup_subsys *ss;
>  6689 struct css_set *cset;
>  6690 int i;
>  6691=20
>  6692 cset =3D kargs->cset;
>  6693 kargs->cset =3D NULL;
>  6694=20
>  6695 scoped_guard(spinlock_irq, &css_set_lock) {
>  6696 /* init tasks are special, only link regular threads */
>  6697 if (likely(child->pid)) {
>  6698 if (kargs->cgrp) {
>  6699 cgrp_flags =3D kargs->cgrp->flags;
>  6700 cgrp_kill_seq =3D kargs->cgrp->kill_seq;
>  6701 } else {
>  6702 cgrp_flags =3D cset->dfl_cgrp->flags;
>  6703 cgrp_kill_seq =3D cset->dfl_cgrp->kill_seq;
>  6704 }
>  6705=20
>  6706 WARN_ON_ONCE(!list_empty(&child->cg_list));
>  6707 cset->nr_tasks++;
>  6708 css_set_move_task(child, NULL, cset, false);
>  6709 } else {
>  6710 put_css_set(cset);
>  6711 cset =3D NULL;
>  6712 }
>  6713=20
>  6714 if (!(child->flags & PF_KTHREAD)) {
>  6715 if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
>  6716 /*
>  6717 * If the cgroup has to be frozen, the new task has
>  6718 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
>  6719 * get the task into the frozen state.
>  6720 */
>> 6721 scoped_guard(spinlock, &child->sighand->siglock) {
>  6722 WARN_ON_ONCE(child->frozen);
>  6723 child->jobctl |=3D JOBCTL_TRAP_FREEZE;
>  6724 }
>  6725=20
>  6726 /*
>  6727 * Calling cgroup_update_frozen() isn't required here,
>  6728 * because it will be called anyway a bit later from
>  6729 * do_freezer_trap(). So we avoid cgroup's transient
>  6730 * switch from the frozen state and back.
>  6731 */
>  6732 }
>  6733=20
>  6734 /*
>  6735 * If the cgroup is to be killed notice it now and take the
>  6736 * child down right after we finished preparing it for
>  6737 * userspace.
>  6738 */
>  6739 kill =3D kargs->kill_seq !=3D cgrp_kill_seq;
>  6740 }
>  6741 }
>  6742 /*
>  6743 * Call ss->fork().  This must happen after @child is linked on
>  6744 * css_set; otherwise, @child might change state between ->fork()
>  6745 * and addition to css_set.
>  6746 */
>  6747 do_each_subsys_mask(ss, i, have_fork_callback) {
>  6748 ss->fork(child);
>  6749 } while_each_subsys_mask();
>  6750=20
>  6751 /* Make the new cset the root_cset of the new cgroup namespace. =
*/
>  6752 if (kargs->flags & CLONE_NEWCGROUP) {
>  6753 struct css_set *rcset =3D child->nsproxy->cgroup_ns->root_cset;
>  6754=20
>  6755 get_css_set(cset);
>  6756 child->nsproxy->cgroup_ns->root_cset =3D cset;
>  6757 put_css_set(rcset);
>  6758 }
>  6759=20
>  6760 /* Cgroup has to be killed so take down child immediately. */
>  6761 if (unlikely(kill))
>  6762 do_send_sig_info(SIGKILL, SEND_SIG_NOINFO, child, PIDTYPE_TGID);
>  6763=20
>  6764 cgroup_css_set_put_fork(kargs);
>  6765 }
>  6766=20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


