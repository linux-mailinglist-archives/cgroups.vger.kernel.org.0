Return-Path: <cgroups+bounces-7242-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A0A734B2
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 15:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE3B3BEF91
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF8217F3D;
	Thu, 27 Mar 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPEbSQ4q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810CD218838;
	Thu, 27 Mar 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086347; cv=none; b=p/BF2KtZaXGaPHh9NJkN/AB9jvi8MOJPtf+Cgq1feLW3fKk6jKzAzxZZ/kPLT+2TPXEiKXysQGCde6SRnofoKgeeVMGWHg6tDbmVkXRUsVXx31n47EGg20wbzeX5TXpI+vBTONVbhFT7vYfLoA4rw8ljE1HUPYl0IwtZSlECC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086347; c=relaxed/simple;
	bh=BGzyf6owM85krelMUgDqZF06wL1TDDO4HodtxJapS7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzvLNxdJX1Mx5V8WoFYfBmt17RAHpiTT+TytuPnnd9tU71SAp5jNp2HkBLs8K+iDE8P5Z+q12OTj2xVflnJwWPjoPrcuv08jYm8IWAQ/95zzavJEaUfOtXbpENt+e0WuNexntsNZo9pB3uyy0ukL5ni7VgfSYEuLtAxPfIjvHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPEbSQ4q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39143200ddaso671957f8f.1;
        Thu, 27 Mar 2025 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743086344; x=1743691144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u82ONPXPU91yIttrfyA9Tihmj4fGNtFwpkyHVRCFmYA=;
        b=FPEbSQ4qVWVgSnYAXASZ1oWErBdCjC3K2o+qojKwairpnkD3efXPaNtljRaAxLuNPX
         mxHrNWE8VpNOewsQzcZ3L45rWfHMxkTP/dzWyRTWt+TZOOwPzK22dVE23uPWRHKOJc38
         UcNbDB5ip+RMYzpOOS0lMEp+AbIZbcKraFnQbFdtVJtFSQ9o363asJC1NTbR+hV/Mdyf
         3xsCg3RiHl9woJEyCZAAf2bMVRoVH+lfTK+tQ76kHr+z793Dtq2C3/da3vCKEbdWVitN
         aBjV5hsdAYEMDspICRIGBKFA0l2L2YTrAuFoEV3K4vWyMCYE/0CCGrBeU8lL8qGjNXiW
         08Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086344; x=1743691144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u82ONPXPU91yIttrfyA9Tihmj4fGNtFwpkyHVRCFmYA=;
        b=F3Iu6i5Bh1rIPeGeyeaYXle+tBj235ucm6igTL7MRwv6r6hZqQ8oS6JEsSA0yEE1M6
         mSXANiHz0zovSJCaCSFBd8PkNTPwfNe1BGRH9tQcqZ+SFBkzeO/3n7thcMrACzhGDu/Z
         slBO/aGZYoILniLFBXY/uNW8ek2dVRn4yCqXAlyTnCIrz8v7ypv371KtcHTsgPH/cvzX
         IF0YoaU3XWcU5IBw+2TOhmPEU+DrWmBur/P4ErDVvE8Wi7I4ycYf9NSPzRuTaFi0uPsa
         e6Q0VuYdAISs4KSa/qvXdHPshGxevb1+f/FFGpOINqbEAv7HQwX9xsJA5/0TIaV+3ygs
         Jznw==
X-Forwarded-Encrypted: i=1; AJvYcCU1mkMcccBwiT69PdxTJ3a7EoelRsUZ2ZxSnJo9Y1cHNReEI4Gzr97nYG4keetb5kaS3187/GJ+@vger.kernel.org, AJvYcCVHeTg6dsoR8xgGe7IPH5Hen4JeoRPNCMz0eT+ulO0VSK2Pz8zm2vfB+6bwhWzQhEpZHkULdFMb/s61cbGF@vger.kernel.org
X-Gm-Message-State: AOJu0YygoCBJ/C4PywCm0ntVv5PicqTkJH/tzeOtAFDV3nSpAqZhJ8LD
	8UWu+cojONEFcdtYyi98HBNcnakugNQf1RWUaucrsI0bHnPewzBH
X-Gm-Gg: ASbGncs9hOVZUG6PGpqh78Mzf6aa+7n5D5tSlUKPt+uHbeK2jjr+hQHbGaTQ6OWlJbo
	F2FbRrj0Ol4I3HV9mPDQrrsYb9IAGSenOWNLCyt0SnWTV6dSuzz4noc6RI+47vlBPcdubOx2EX7
	VWZ+/JIJqnMMk/oZNMYFN8WwaUYUjVH6T3eiovvvupDnghF00UqWuHSWOEQWQtscYkJer3neYD1
	1A21whjGIUA9WQLLAj/dFMk9gUAWA5qlRiKSHYFE1CrgvtpjLatIYfKlEsP8S+fR4LipEBMMksK
	1i4tYaODYzY+E4t57fHUEYFrheP86bijd6AludPwlcChd66sVJvPgHI/kg==
X-Google-Smtp-Source: AGHT+IHIYyxBLsfyfwB72W3HrvPr9/6S85TLty5UHu4H+YbkreFKm3JMZPvoIHJpmVfVuy6D/+deUQ==
X-Received: by 2002:a05:6000:1889:b0:391:48d4:bcf2 with SMTP id ffacd0b85a97d-39ad1749a44mr3201709f8f.12.1743086343393;
        Thu, 27 Mar 2025 07:39:03 -0700 (PDT)
Received: from f (cst-prg-15-56.cust.vodafone.cz. [46.135.15.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6539sm20191479f8f.77.2025.03.27.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:39:02 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:38:50 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
References: <20250319071330.898763-1-gthelen@google.com>
 <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
 <Z9r8TX0WiPWVffI0@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fqcrruvxc7rr34k3"
Content-Disposition: inline
In-Reply-To: <Z9r8TX0WiPWVffI0@google.com>


--fqcrruvxc7rr34k3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Mar 19, 2025 at 05:18:05PM +0000, Yosry Ahmed wrote:
> On Wed, Mar 19, 2025 at 11:47:32AM +0100, Mateusz Guzik wrote:
> > Is not this going a little too far?
> > 
> > the lock + irq trip is quite expensive in its own right and now is
> > going to be paid for each cpu, as in the total time spent executing
> > cgroup_rstat_flush_locked is going to go up.
> > 
> > Would your problem go away toggling this every -- say -- 8 cpus?
> 
> I was concerned about this too, and about more lock bouncing, but the
> testing suggests that this actually overall improves the latency of
> cgroup_rstat_flush_locked() (at least on tested HW).
> 
> So I don't think we need to do something like this unless a regression
> is observed.
> 

To my reading it reduces max time spent with irq disabled, which of
course it does -- after all it toggles it for every CPU.

Per my other e-mail in the thread the irq + lock trips remain not cheap
at least on Sapphire Rapids.

In my testing outlined below I see 11% increase in total execution time
with the irq + lock trip for every CPU in a 24-way vm.

So I stand by instead doing this every n CPUs, call it 8 or whatever.

How to repro:

I employed a poor-man's profiler like so:

bpftrace -e 'kprobe:cgroup_rstat_flush_locked { @start[tid] = nsecs; } kretprobe:cgroup_rstat_flush_locked /@start[tid]/ { print(nsecs - @start[tid]); delete(@start[tid]); } interval:s:60 { exit(); }'

This patch or not, execution time varies wildly even while the box is idle.

The above runs for a minute, collecting 23 samples (you may get
"lucky" and get one extra, in that case remove it for comparison).

A sysctl was added to toggle the new behavior vs old one. Patch at the
end.

"enabled"(1) means new behavior, "disabled"(0) means the old one.

Sum of nsecs (results piped to: awk '{ sum += $1 } END { print sum }'):
disabled:	903610
enabled:	1006833 (+11.4%)

Toggle at runtime with:
sysctl fs.magic_tunable=0 # disabled, no mandatory relocks
sysctl fs.magic_tunable=1 # enabled, relock for every CPU

I attached the stats I got for reference.

I patched v6.14 with the following:
diff --git a/fs/file_table.c b/fs/file_table.c
index c04ed94cdc4b..441f89421413 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -106,6 +106,8 @@ static int proc_nr_files(const struct ctl_table *table, int write, void *buffer,
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+unsigned long magic_tunable;
+
 static const struct ctl_table fs_stat_sysctls[] = {
 	{
 		.procname	= "file-nr",
@@ -123,6 +125,16 @@ static const struct ctl_table fs_stat_sysctls[] = {
 		.extra1		= SYSCTL_LONG_ZERO,
 		.extra2		= SYSCTL_LONG_MAX,
 	},
+	{
+		.procname	= "magic_tunable",
+		.data		= &magic_tunable,
+		.maxlen		= sizeof(magic_tunable),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= SYSCTL_LONG_ZERO,
+		.extra2		= SYSCTL_LONG_MAX,
+	},
+
 	{
 		.procname	= "nr_open",
 		.data		= &sysctl_nr_open,
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 3e01781aeb7b..f6444bf25b2f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -299,6 +299,8 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
+extern unsigned long magic_tunable;
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
@@ -323,12 +325,18 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 			rcu_read_unlock();
 		}
 
-		/* play nice and yield if necessary */
-		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
+		if (READ_ONCE(magic_tunable)) {
 			__cgroup_rstat_unlock(cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
 			__cgroup_rstat_lock(cgrp, cpu);
+		} else {
+			if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
+				__cgroup_rstat_unlock(cgrp, cpu);
+				if (!cond_resched())
+					cpu_relax();
+				__cgroup_rstat_lock(cgrp, cpu);
+			}
 		}
 	}
 }


--fqcrruvxc7rr34k3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=disabled

69869
30473
64670
30544
30950
36445
36235
29920
51179
35760
33424
42426
30177
31211
44974
34450
37871
72642
33016
29518
31800
35730
30326

--fqcrruvxc7rr34k3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=enabled

63507
50113
36280
35148
63329
41232
51265
41341
41418
42824
35200
35550
54684
41597
55325
36120
48675
41179
39339
35794
38826
37411
40676

--fqcrruvxc7rr34k3--

