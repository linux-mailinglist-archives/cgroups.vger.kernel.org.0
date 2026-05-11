Return-Path: <cgroups+bounces-15744-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMVjJ3rGAWqSjgEAu9opvQ
	(envelope-from <cgroups+bounces-15744-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:07:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB2D50D523
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2004630098B5
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E369337AA72;
	Mon, 11 May 2026 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jqX6ZhlX"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2A3783B1;
	Mon, 11 May 2026 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501239; cv=none; b=jaN8+pD+Rxtd4zFPFODwtQ3EfjgKy8VXbcL6DCM58qmD2cZJOJSSC/1XT4Y/TqA5qbom9MOhaaDZu5eyjuzhHzpLBA+JDGBIYYiYNpN25DWPcWHAI2Zw4/naQr2F/jSzpnMUXbg+SUccbmWEJe4pQkWFzT1nlUfSCmoCLxQaZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501239; c=relaxed/simple;
	bh=35Kv0mlRvH3hwlj9HeKuME4m7V56VBlCI/r94DX+fOs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=XnO3BGWRbXHfm9N5Vh4BYiph+KAT1rs6Si5DzuxL2RLNEL363pss3d1mOv80fLNLl01ifH3IsmUFLmc42R4jSHjWKii3J02WbqZc4e2mVevPLQX4yXfHLpZPqhbMuecejthWtvgQ5KDMhpad0P1Ff+vQWDJPc/LOH0S7I2ns5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jqX6ZhlX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gwoa4YLIjBkQq4z+z/ifxnVXEuuhlOQhZT1BuSyrH0I=; b=jqX6ZhlXz54tOsKUTFR2LuxSz5
	kzS2YaWznndls1PlM6OiJwEmkuMtbpkdkAtnTMj1qrDZR6gR30MWjt+1MmD2/UfOjqjV+lYi7jvoW
	qEuThLpz76wgo4HSQtIQElCxlvG4lfQyLLGlIs+ruZehLwn/sT7LzClHJscdutwHv03+e+hVZ1882
	dW2WX8fVbjJID5THR4mHk1qkXaUpHYzjKFaUUrDpi9iIJOdAQpB7eKJypATRmRZhA3ZKe7Ae1GDCA
	WHyfV1QT2gDBGDmAMoZuqQOEoZXobv1hUGkO3FyGY9kqgVbUAtj1O4fH4pUo5u0t//TTrVS6iE9n5
	GBkv/Byw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPZ-000000088lz-2R6S;
	Mon, 11 May 2026 12:07:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0698730063F; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511113104.563854162@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com,
 qyousef@layalina.io
Subject: [PATCH v2 00/10] sched: Flatten the pick
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: ECB2D50D523
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-15744-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,msgid.link:url,spin.sh:url]
X-Rspamd-Action: no action

Hi!

So cgroup scheduling has always been a pain in the arse. The problems start
with weight distribution and end with hierachical picks and it all sucks.

The problems with weight distribution are related to that infernal global
fraction:

             tg->w * grq_i->w
   ge_i->w = ----------------
             \Sum_j grq_j->w

which we've approximated reasonably well by now. However, the immediate
consequence of this fraction is that the total group weight (tg->w) gets
fragmented across all your CPUs. And at 64 CPUs that means your per-cpu cgroup
weight ends up being a nice 19 task worth. And more CPUs more tiny. Combine
with the fact that 256 CPU systems are relatively common these days, this
becomes painful.

The common 'solution' is to inflate the group weight by 'nr_cpus'; the
immediate problem with that is that when all load of a group gets concentrated
on a single CPU, the per-cpu cgroup weight becomes insanely large, easily
exceeding nice -20.

Additionally there are numerical limits on the max weight you can have before
the math starts suffering overflows. As such there is a definite limit on the
total group weight. Which has annoyed people ;-)

The first few patches add a knob /debug/sched/cgroup_mode and a few different
options on how to deal with this. My favourite is 'concur', but obviously that
is also the most expensive one :-/ It adds a tg->tasks counter which makes the
update_tg_load_avg() thing more expensive.

I have some ideas but I figured I ought to share these things before sinking
more time into it.


On to the hierarchical pick; this has been causing trouble for a very long
time. So once again an attempt at flatting it. The basic idea is to keep the
full hierarchical load tracking as-is, but keep all the runnable entities in a
single level. The immediate concequence of all this is ofcourse that we need to
constantly re-compute the effective weight of each entity as things progress.

Reweight is done on:
 - enqueue
 - pick -- or rather set_next_entity(.first=true)
 - tick

So while the {en,de}queue operations are still O(depth) due to the full
accounting mess, the pick is now a single level. Removing the intermediate
levels that obscure runnability etc.


For testing, I've done a little experiment, I dug out what is colloqually known
as a potato. A trusty old Sandybridge 12600k with a RX 580, and ran a game on
it. From GOG, I had available 'Shadows: Awakens', a fun title that normally
runs really well on this machine (provided you stick to 1080p).

To make it interesting, I added 8 (one for each logical CPU) copies of: 'nice
spin.sh'; this results in the game becoming almost unplayable, as in proper
terrible.

I used MangoHUD to record a few minutes of playtime for statistics, and then
quit the came and re-started it with a shorter slice set (base/10). This
results in the game being entirely playable -- not great, but definiltey
playable.

  Lutris / GE-Proton10-34 / Steam Runtime 3 (sniper)
  Intel Core i7-2600K
  AMD Radeon RX 580

  Shadows Awakening (GOG)

	  default slice(*)

  FPS min  3.8    20.6
      avg 48.0    57.2
      mag 87.4    80.3

  FT  min   9.4    8.4
      avg  34.5   19.5
      max 107.4   37.2

  FPS (Frames Per Second)
  FT  (FrameTime)

  [*] Command prefix: 'chrt -o --sched-runtime 280000 0'
      effectively setting 'base_slice_ns/10'

I have not compared to a kernel without flat on, just wanted to run non trivial
workloads and play with slice to make sure everything 'works'.


Can also be had:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/flat

 include/linux/cpuset.h |    6 
 include/linux/sched.h  |    1 
 kernel/cgroup/cpuset.c |   15 
 kernel/sched/core.c    |   47 --
 kernel/sched/debug.c   |  171 +++++---
 kernel/sched/fair.c    | 1038 ++++++++++++++++++++++---------------------------
 kernel/sched/pelt.c    |    6 
 kernel/sched/sched.h   |   44 --
 8 files changed, 672 insertions(+), 656 deletions(-)

---
Change since v1 ( https://patch.msgid.link/20260317095113.387450089@infradead.org ):
 - various Sashiko thingies
 - rebase atop curren -tip



