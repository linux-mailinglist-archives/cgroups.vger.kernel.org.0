Return-Path: <cgroups+bounces-17231-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cy6RKmDTO2ojdwgAu9opvQ
	(envelope-from <cgroups+bounces-17231-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 14:53:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC06BE495
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 14:53:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b=iKR9o3Qw;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17231-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17231-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98E143016BB1
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226713AFD17;
	Wed, 24 Jun 2026 12:53:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8EC3AFCE8
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 12:53:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305626; cv=none; b=jA70gyPsDBVzGlOGbq8cIdd9Ld3X2KakaB3IJ+ZC+Z9mTmq75IqAc5n+sn+1G6Ir0JUptBB+k2KlwkNR4/j/SInd4wPngNLfONH6caT6/AYTxCMROe/tUBKlG1rvVorpVINMhKbRBRMcwhzUj7CYPLPNxdO+3W6BDl8PlWwWqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305626; c=relaxed/simple;
	bh=PD5G12xOLAzov5JHtwUfORhnpKpMIKv8xa6F4df83q4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n9UpMTxJbNWGWbN1tkLJMCWWwo5JymtXc0Qc7AoxxOQbjCUPEsdisAwq+26bcsCCLOxfFLs/BQZoy6oAp1X+m6YVoViZT2BqrjoR4K1GQP5ivb4Y0WVI0pMu4TxTdKxcFJnh3U01Jw/bXBuEXjai3mBVA0LHlV+rT24oL4J5Mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=iKR9o3Qw; arc=none smtp.client-ip=209.85.161.48
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69d7e72b052so841016eaf.2
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782305624; x=1782910424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyUeAUZQ6VzVD4aBIbLL3a1KL2Cf5FHGMKxIglpvK8o=;
        b=iKR9o3QwbepTq/2a2Wp5FqxlB6hzT5IufFFzkhh+DcF7ep3phwz+eGSmNbSIIBMVhX
         9kPvG5ntkzZqWL2AZk3Ft6zHIhd8Unk8SMtM3noB6aL1SjZOuT6+/+Oq8N3f6eZHfsPk
         2xPZJ9b4IPcR56Gv+LK5/73JLPdaL31MIm9JwYeDw3nGELuyTV51Gay0HTDTvGjwyNMq
         JFIQDSMhUgJJZMKRFTviNYIenQnQ5AwVJa0t71HjxXuWokZjwm5gePgRxQdyYOJByXkY
         NC9HbJNXhFiGo4H8OHHhbJurhKF+kNNUrMvMiNhPZ4tNz6Ws1LmzTseJSnjNLs9W0pn+
         nGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305624; x=1782910424;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yyUeAUZQ6VzVD4aBIbLL3a1KL2Cf5FHGMKxIglpvK8o=;
        b=R7o32NdUEBdWash7g7Yr4gJ+MvjaU2YzqybOEj6+o5v7CTF1UghLawrYK6CIQOeuDU
         f8fmSDbBu3oFeWq3R/af7ojrvcIpa+FiwPoCXU0G1EaIUneAu6bihEqx8ZGiHe27Uu17
         0rQx9kYsjCXKVBB3jqoUk/kr7ScFMIJh30IDaCXdS3M/r2o6BOK4tNgA0qsjbABCgid+
         uENIDhpDsG2ulmPGioBnGPgvboCIS0MWUBpNeqV28FnbiJvAAlFU29SO6Ob5iLe+A+MY
         rbMlAQjYHTldVl18SsFx0V3e97yK18XTpc8JfpDiDCmIJz93Kw48GDkTZarMRMshihMS
         wNMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ybTka5o6DoYUA07Kq3U6n82IkORKuZuAN6tWW+wA3ggAFgNJzl35qnpAoOksoOAes+Pe0GI98@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9h0GF1w+0x25dGCiC0v7NCbRh2KiZavj2tOuUnZGQRipmvUR
	TADiG7/eylynNWmRutAjB0kivNv2HEirK0uUFBqCAsGkMIHEZQPs75NWndL47mXdlDA=
X-Gm-Gg: AfdE7cmG1vCeUSoizo2Qj8/ydP4monsHen802/Zhrp9S8EJAMsCoG8swAGOz8n5yQtM
	Ma+ILIDwc9OvQ1cv3NMKo3NBTxudnfKfUIWC3IKGr7oJWTnkTxD2ZWdQB+5Ew9FlBoBLwWXdRLl
	NtRIU8wwm8u21m3GhuW7tHxdlLXJA0Ggy6+z+WVoy2LhfIyDNUktQ6S+igtKf3gxA655m6vTD9Q
	xHUDuAgg/4euqcoaA86W2yPDWel1De0RbtCvk8/VklEqziFcU615iCIv0DvY+cC9gwWBgF6SxDl
	3H9OwjOMB7x5olpSTKnWSdKBB9vwaJZc1Us821AQHBY18y3Hzfszzh3mLkQKt/k+qX95OlJqbms
	ZOgDq3546EH0pazBVBJiR6GQQSOUVC7ZqEkLVgjL7yF9cBdoS9Pm1TBqE/19slZRnaMmd0VlBbx
	LrSk93VNivAdx15WL4SOsNILIAeSPDUdaVzS4Hjsr0TfBEwnaV4js2pwZ9xYO86z9ihA==
X-Received: by 2002:a05:6820:2222:b0:69e:9c80:2fa0 with SMTP id 006d021491bc7-6a1230575c0mr1922407eaf.17.1782305624088;
        Wed, 24 Jun 2026 05:53:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9faf29asm9264161eaf.8.2026.06.24.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:53:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, tom.leiming@gmail.com, bvanassche@acm.org, 
 tj@kernel.org, josef@toxicpanda.com, yukuai@fygo.io, 
 Yu Kuai <yukuai@kernel.org>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
 shikemeng@huaweicloud.com, nphamcs@gmail.com, baohua@kernel.org, 
 youngjun.park@lge.com, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Baoquan He <baoquan.he@linux.dev>
In-Reply-To: <cover.1780621988.git.yukuai@fygo.io>
References: <cover.1780621988.git.yukuai@fygo.io>
Subject: Re: [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg
 paths
Message-Id: <178230562124.29628.5186654393991521598.b4-ty@b4>
Date: Wed, 24 Jun 2026 06:53:41 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nilay@linux.ibm.com,m:tom.leiming@gmail.com,m:bvanassche@acm.org,m:tj@kernel.org,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:yukuai@kernel.org,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baohua@kernel.org,m:youngjun.park@lge.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:baoquan.he@linux.dev,m:tomleiming@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com,acm.org,kernel.org,toxicpanda.com,fygo.io];
	FORGED_SENDER(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17231-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,huaweicloud.com,gmail.com,lge.com,vger.kernel.org,kvack.org,linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kernel.dk:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BAC06BE495


On Mon, 08 Jun 2026 11:42:41 +0800, Yu Kuai wrote:
> This series is the follow-up blk-cgroup locking cleanup on top of the
> earlier blkg-list protection fixes, and prepares blk-cgroup to stop using
> q->queue_lock as the global blkg lifetime/iteration lock.
> 
> The current queue_lock based protection is hard to maintain because
> queue_lock is used from hardirq and softirq completion paths, while some
> blkcg cgroup file paths also need to iterate blkgs, print policy data, or
> create blkgs from RCU-protected contexts.  This series first tightens the
> blkcg-side lifetime rules:
> 
> [...]

Applied, thanks!

[1/8] blk-cgroup: protect iterating blkgs with blkcg->lock in blkcg_print_stat()
      commit: 25656304dabd26198ec69460c594a19d086ef099
[2/8] blk-cgroup: delay freeing policy data after rcu grace period
      commit: 0af3fedb8c8ed3c07b4f76927bd7fc88f6f82efb
[3/8] blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()
      commit: 56cc24f59c145ce6938959f792df04b8a4f5a4d8
[4/8] blk-cgroup: don't nest queue_lock under rcu in blkg_lookup_create()
      commit: 9327a865e395a53f67dffac4710beb1d4730495e
[5/8] blk-cgroup: don't nest queue_lock under rcu in bio_associate_blkg()
      commit: 457d3c4f0fdd6cf8a4bd8115bf470809984a9f02
[6/8] blk-cgroup: don't nest queue_lock under blkcg->lock in blkcg_destroy_blkgs()
      commit: 4cfd7c1cff8f4c863b99d420cdbe0563802a9e80
[7/8] mm/page_io: don't nest queue_lock under rcu in bio_associate_blkg_from_page()
      commit: f928145cbcb52544203808f159461d0a25543df7
[8/8] block, bfq: don't grab queue_lock to initialize bfq
      commit: 3ca4f4e3ae811d414076a491cbf0dfcdae0dc01e

Best regards,
-- 
Jens Axboe




