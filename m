Return-Path: <cgroups+bounces-14744-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG59DWaxsGnGmAIAu9opvQ
	(envelope-from <cgroups+bounces-14744-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 01:03:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CA32597B4
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 01:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43A1D302C310
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 00:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6279A2AD2C;
	Wed, 11 Mar 2026 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoqJBhWy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E51CF8B
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187427; cv=none; b=iodvBgsWcpe6CJdZ+DBUWMRyy688++C4soCFI8vWJCQjKFe+/VmRo0E2rU3EkmJxz558xLkA7y5lGioHbIyjx2eg039TE6MyGp8qQBEH1F5Cv49qvrRlXk9/CLyG9LpPoOcPK/YabGNCmXXn+OFRSADvrWCkir2oIHPxah9qo8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187427; c=relaxed/simple;
	bh=OPUJ4s88R0yZQAwpWNYDy3ROXydlsJZHpzZ4DP0zHBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=C2RObW61G9FwxIFhL5YxAxVxrZ2Cvboc20W5BrH6Gc0myNqgCSGC6+y9lVOCQ6tw7OwI3rfQ8570/6ZpIcImefwb6HurXgkIBdXb9W1za3EOLTIHT7yWpcbs2WbkT0hTw3qyvB0UMErxUs43VJlAVazVHiSeTUGa2XkndxOR4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoqJBhWy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852ff06541so37490815e9.2
        for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773187424; x=1773792224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Th9+VLFBVmNjfXAWGXevm/XrdfOj2rwXBpkvnIti7NM=;
        b=FoqJBhWyYb0orbprGwK0UhlE7uzkut9aDCHcIJaJtPNn9/GAAQ0cOvKdENYC39AiEQ
         WEoS62KUOSfwJC2b2LQAgZ+LOLBz4/oz09UXJCjuAp8UNpkwDEV7pFvnIV1xy+lx/D6J
         ZBgifnOg1dT4yEyznSy1HhFrjdhvdyHvhizRSDa8G1lXdMv4mnwtOX6EJO+e0n56a4iT
         zDRYvpLjBB5pxB0FjenTjAsldBHA65MRsspwV1E6p0nB3o6iW8Vs649BgnBwz5WDMmn2
         9rBAA8P0W1Ku+LVZNdfANSEGrdRPs+whaYzrEskIrRLg8GMx69WroET8hU739Y1YSQib
         qW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773187424; x=1773792224;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th9+VLFBVmNjfXAWGXevm/XrdfOj2rwXBpkvnIti7NM=;
        b=dRoYxWReIs4Wk2t0f+HAqT9+UKlDAb2juRT3ORTtiWRxtzITBCTAcaUjW5FGstLr5A
         +SL/kNFN8GEEx04pKJBoYpLq2hjiTTRKJUIkWHccUweKnWK70cAwI3hwo1mVlMc7HVls
         kS5crj0z+8NsPHWwPpGvsteC2r5xrsK1NmduN97D45WMokbp/CNqd19hANomr8z6MUmh
         85NcPtnSO+0cQ9O4R7fB8bx8MZVgTq7Om3W326sE6XLJJ7QnBs+GushUYIEzod8bG6iW
         eG2AL8tMTJvMP1JeIZ49zhr1gieYeC36QQjXUwDHk6cKixSDJKn7qACJ5w3SeAIOGVKP
         nlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd+KPkkonazvKJRjHtYPkbe+wNger/n9Kba8RY06VHuDhDXzgaZ7pkoem+tqtdKm7uQ9KLfR7/@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzQiFWV8rdE0QuN4Rnn/9GqRwQCBt4q0FEwFdTG6m8PL60dNI
	FifTjBkuBUtB0mvgXXsz8dbWRdA+j2miIdN12qD1/iBAE5ithwMTxdyy
X-Gm-Gg: ATEYQzwYA/o0G71vur8S+vSZOc8eUZNTHYp7c+/1jBfRisfB8Ss5vZ2EtC4XR+H+qrN
	/krudyU0hM2CHynWOD6j85WjDcvAHY+hkTSzgRMo+bRIC1WNMERSXGNhDLwzK7vUuatAoA+tTlH
	Ta6gkm2ghDoUCgSPn0shMCgToWUWCiqnjJ2mKUzlswnEN2Laet6JE/ptxB4GPw1KKF7tCg6tON3
	JgtW804sf80DCyykFZ5eG0/a7CIH++VBTmuJSU6gDfZD2oRnXii6uMD/ouNnnJFaHocwrlmqMZc
	Zhbv1vOOUYZzEKb5/gPy3zhigHkioUsPDAzaD1lL7gPYA47DG7fEb/aPodRoyU48piMidQ+/Ak1
	w9mSqP6SbJM7HWk7QV7UHpE6ircN+4ZZhb1WqMp3ztxwr6jUWF9OSDNuTcfgl3FDLD5GfnDvs0L
	TEVeSxQmzpgNPAYPWXX0iajnM/J7Wnpvun+lzlEW9tG6Halw==
X-Received: by 2002:a05:600c:4510:b0:483:c35d:367f with SMTP id 5b1f17b1804b1-4854b0fe742mr10028125e9.21.1773187423502;
        Tue, 10 Mar 2026 17:03:43 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ac17f2sm105012385e9.6.2026.03.10.17.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:03:43 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Date: Tue, 10 Mar 2026 21:03:41 -0300
Message-ID: <abCxXZCJPgNuOPG2@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <abCL8vE3cttL1Yq0@tpad>
References: <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka> <aZDw6xI2izFDfuuu@WindFlash> <aZL45yORfkNvS9Rs@tiehlicka> <aZjY9h3XXMNY-Ytd@WindFlash> <aZwYmNuucBspCYhk@tiehlicka> <aaJDjmnfuo8AM6J9@WindFlash> <aaYpICV55B70U1I2@tpad> <aa20uDGqnmiqYJ1w@WindFlash> <abCL8vE3cttL1Yq0@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2CA32597B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14744-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fedvm:email,lpc.events:url]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 06:24:02PM -0300, Marcelo Tosatti wrote:
> On Sun, Mar 08, 2026 at 02:41:12PM -0300, Leonardo Bras wrote:
> > On Mon, Mar 02, 2026 at 09:19:44PM -0300, Marcelo Tosatti wrote:
> > > On Fri, Feb 27, 2026 at 10:23:27PM -0300, Leonardo Bras wrote:
> > > > On Mon, Feb 23, 2026 at 10:06:32AM +0100, Michal Hocko wrote:
> > > > > On Fri 20-02-26 18:58:14, Leonardo Bras wrote:
> > > > > > On Mon, Feb 16, 2026 at 12:00:55PM +0100, Michal Hocko wrote:
> > > > > > > On Sat 14-02-26 19:02:19, Leonardo Bras wrote:
> > > > > > > > On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> > > > > > > > > On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > > > > > > > > > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > > > > > > > > [...]
> > > > > > > > > > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > > > > > > > > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > > > > > > > > > have requirements as strong as RT workloads but the underlying
> > > > > > > > > > > fundamental problem is the same. Frederic (now CCed) is working on
> > > > > > > > > > > moving those pcp book keeping activities to be executed to the return to
> > > > > > > > > > > the userspace which should be taking care of both RT and non-RT
> > > > > > > > > > > configurations AFAICS.
> > > > > > > > > > 
> > > > > > > > > > Michal,
> > > > > > > > > > 
> > > > > > > > > > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > > > > > > > > > boot option qpw=y/n, which controls whether the behaviour will be
> > > > > > > > > > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > > > > > > > > 
> > > > > > > > > My bad. I've misread the config space of this.
> > > > > > > > > 
> > > > > > > > > > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > > > > > > > > > (and remote work via work_queue) is used.
> > > > > > > > > > 
> > > > > > > > > > What "pcp book keeping activities" you refer to ? I don't see how
> > > > > > > > > > moving certain activities that happen under SLUB or LRU spinlocks
> > > > > > > > > > to happen before return to userspace changes things related 
> > > > > > > > > > to avoidance of CPU interruption ?
> > > > > > > > > 
> > > > > > > > > Essentially delayed operations like pcp state flushing happens on return
> > > > > > > > > to the userspace on isolated CPUs. No locking changes are required as
> > > > > > > > > the work is still per-cpu.
> > > > > > > > > 
> > > > > > > > > In other words the approach Frederic is working on is to not change the
> > > > > > > > > locking of pcp delayed work but instead move that work into well defined
> > > > > > > > > place - i.e. return to the userspace.
> > > > > > > > > 
> > > > > > > > > Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> > > > > > > > > paths like SLUB sheeves?
> > > > > > > > 
> > > > > > > > Hi Michal,
> > > > > > > > 
> > > > > > > > I have done some study on this (which I presented on Plumbers 2023):
> > > > > > > > https://lpc.events/event/17/contributions/1484/ 
> > > > > > > > 
> > > > > > > > Since they are per-cpu spinlocks, and the remote operations are not that 
> > > > > > > > frequent, as per design of the current approach, we are not supposed to see 
> > > > > > > > contention (I was not able to detect contention even after stress testing 
> > > > > > > > for weeks), nor relevant cacheline bouncing.
> > > > > > > > 
> > > > > > > > That being said, for RT local_locks already get per-cpu spinlocks, so there 
> > > > > > > > is only difference for !RT, which as you mention, does preemtp_disable():
> > > > > > > > 
> > > > > > > > The performance impact noticed was mostly about jumping around in 
> > > > > > > > executable code, as inlining spinlocks (test #2 on presentation) took care 
> > > > > > > > of most of the added extra cycles, adding about 4-14 extra cycles per 
> > > > > > > > lock/unlock cycle. (tested on memcg with kmalloc test)
> > > > > > > > 
> > > > > > > > Yeah, as expected there is some extra cycles, as we are doing extra atomic 
> > > > > > > > operations (even if in a local cacheline) in !RT case, but this could be 
> > > > > > > > enabled only if the user thinks this is an ok cost for reducing 
> > > > > > > > interruptions.
> > > > > > > > 
> > > > > > > > What do you think?
> > > > > > > 
> > > > > > > The fact that the behavior is opt-in for !RT is certainly a plus. I also
> > > > > > > do not expect the overhead to be really be really big. 
> > > > > > 
> > > > > > Awesome! Thanks for reviewing!
> > > > > > 
> > > > > > > To me, a much
> > > > > > > more important question is which of the two approaches is easier to
> > > > > > > maintain long term. The pcp work needs to be done one way or the other.
> > > > > > > Whether we want to tweak locking or do it at a very well defined time is
> > > > > > > the bigger question.
> > > > > > 
> > > > > > That crossed my mind as well, and I went with the idea of changing locking 
> > > > > > because I was working on workloads in which deferring work to a kernel 
> > > > > > re-entry would cause deadline misses as well. Or more critically, the 
> > > > > > drains could take forever, as some of those tasks would avoid returning to 
> > > > > > kernel as much as possible. 
> > > > > 
> > > > > Could you be more specific please?
> > > > 
> > > > Hi Michal,
> > > > Sorry for the delay
> > > > 
> > > > I think Marcelo covered some of the main topics earlier in this 
> > > > thread:
> > > > 
> > > > https://lore.kernel.org/all/aZ3ejedS7nE5mnva@tpad/
> > > > 
> > > > But in syntax:
> > > > - There are workloads that are projected not avoid as much as possible 
> > > > return to kernelspace, as they are either cpu intensive, or latency 
> > > > sensitive (RT workloads) such as low-latency automation.
> > > > 
> > > > There are scenarios such as industrial automation in which 
> > > > the applications are supposed to reply a request in less than 50us since it 
> > > > was generated (IIRC), so sched-out, dealing with interruptions, or syscalls 
> > > > are a no-go. In those cases, using cpu isolation is a must, and since it 
> > > > can stay really long running in userspace, it may take a very long time to 
> > > > do any syscall to actually perform the scheduled flush.
> > > > 
> > > > - Other workloads may need to use syscalls, or rely in interrupts, such as 
> > > > HPC, but it's also not interesting to take long on them, as the time spent 
> > > > there is time not used for processing the required data.
> > > > 
> > > > Let's say that for the sake of cpu isolation, a lot of different
> > > > requests made to given isolated cpu are batched to be run on syscall 
> > > > entry/exit. It means the next syscall may take much longer than 
> > > > usual.
> > > > - This may break other RT workloads such as  sensor/sound/image sampling, 
> > > > which could be generally ok with some of the faster syscalls for their 
> > > > application, and now may perceive an error because one of those syscalls 
> > > > took too long. 
> > > > 
> > > > While the qpw approach may cost a few extra cycles, it operates remotelly 
> > > > and makes the system a bit more predictable. 
> > > > 
> > > > Also, when I was planning the mechanism, I remember it was meant to add 
> > > > zero overhead in case of CONFIG_QPW=n, very little overhead in case of 
> > > > CONFIG_QPW=y + qpw=0 (a couple of static branches, possibly with the 
> > > > cost removed by the cpu branch predictor),  and only add a few cycles in 
> > > > case of qpw=1 + !RT. Which means we may be missing just a few adjustments 
> > > > to get there.
> > > 
> > > Leo,
> > > 
> > > v2 of the patchset adds only 2 cycles to CONFIG_QPW=y + qpw=0. 
> > > The larger overhead was due to migrate_disable, which is now (on v2)
> > > hidden inside the static branch.
> > > My bad.
> > 
> > Hi Marcelo,
> > 
> > Great, hiding migrate_disable under the static branch is the best scenario.
> > 
> > I wonder why we spend 2 cycles on the static branches, though, should be 
> > close to nothing unless the branch predictor is too busy already. Well, we 
> > can always try to optimize in a different way.
> > 
> > Thanks for the effort on this!
> 
> Leo,
> 
> migrate_enable was leaking out of the static key section 
> into the common error path.
> 
> With preempt_disable, as suggested by Vlastimil, those 2 cycles are
> gone:
> 
> [   61.217232] kmalloc_bench: Avg cycles per kmalloc: 164
> [   68.047789] kmalloc_bench: Avg cycles per kmalloc: 165
> [   73.266568] kmalloc_bench: Avg cycles per kmalloc: 165
> [  120.634168] kmalloc_bench: Avg cycles per kmalloc: 164
> [  127.617872] kmalloc_bench: Avg cycles per kmalloc: 164
> [  157.803679] kmalloc_bench: Avg cycles per kmalloc: 163
> [root@fedvm kmalloc-perf-test]# dmesg | grep qpw
> [    0.000000] Command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-tip root=UUID=35cfa00b-ed70-483f-b7b2-1964e14f719e ro rootflags=subvol=root console=ttyS0,115200 qpw=0 skew_tick=1 tsc=reliable rcupdate.rcu_normal_after_boot=1 rcutree.nohz_full_patience_delay=1000 isolcpus=managed_irq,domain,14,15 amd_pstate=disable nosoftlockup crashkernel=1024M
> [    0.118274] Kernel command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-tip root=UUID=35cfa00b-ed70-483f-b7b2-1964e14f719e ro rootflags=subvol=root console=ttyS0,115200 qpw=0 skew_tick=1 tsc=reliable rcupdate.rcu_normal_after_boot=1 rcutree.nohz_full_patience_delay=1000 isolcpus=managed_irq,domain,14,15 amd_pstate=disable nosoftlockup crashkernel=1024M
> 

Ohh, awesome then.
That means we can have a QPW-enabled kernel and zero overhead perceived if 
qpw=0, right?

(Yeah, instruction cache will have to fetch extra instructions, but 
hopefully that stays hidden enough.)

Thanks!
Leo

