Return-Path: <cgroups+bounces-15177-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJxeB1H302k4ogcAu9opvQ
	(envelope-from <cgroups+bounces-15177-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Apr 2026 20:11:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E873A60C3
	for <lists+cgroups@lfdr.de>; Mon, 06 Apr 2026 20:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE3230134B0
	for <lists+cgroups@lfdr.de>; Mon,  6 Apr 2026 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B55390219;
	Mon,  6 Apr 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMj2OxG3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECA392C47
	for <cgroups@vger.kernel.org>; Mon,  6 Apr 2026 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499083; cv=none; b=TMAxmi/yFD59ZPeTxrfQPRYhkROGr3q2d5z/UlNO/lQZdZao4Hy7di8t6qoDnmZJRdQ8LP05MwELR6oxfBJqEalgO7PUwIRztLJphaIDEMOJRFOnuyc+zWDrRx49U+XnVelfClWDDldlzT7RV25hVvW7kQvMgi7VQz95ZYto0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499083; c=relaxed/simple;
	bh=mvJHDQSniuPRVZlhKG7TgD8Kalt9wGJugRQKAMePGzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogp6pIeicA2MxiKrNPDjyPuYU1/72p5cay+rLZvyWc7uC0xZAsM9gtf5vOELqDxZAxFb2/a7EYTkkf27Gq8XNAXJQRKRjX3AudPQUNcdrUPkJOoXbNUEL157DzdBDhku13KgJ8BRG7sG7JAYp2O/JzD3J/tpFp0H64XGQkko8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMj2OxG3; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1623264fac.3
        for <cgroups@vger.kernel.org>; Mon, 06 Apr 2026 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775499079; x=1776103879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TnCmX+3/CCMvkLoaDVEag7E8oCzFpXmbhOnswXUGMo=;
        b=UMj2OxG3ecKWh1FDE08uukTWTT8W9SbEGjMMHVbjDRjROzlWpOKOlRZQXFQInZe3gL
         xd7KZpOliIgoXE4eTXXJJLuebLI7SZ5GtJKJtMcRy2UbAYZzsc11uCKMUf4I2iQ33ogl
         M+UgQdejoseRp57+Of4HETjuGAHxgsuTvoWE3RUB/CQ+8D01am4g5MPyzu25SpMJ0GQt
         bPaSBU6COFrEPkDgHOunaHoS9504ObpksD3H42f0W9YJChhDBaFZM5a8rRvnuFuJLVep
         /3PsQ44q1AcQuMda2N8Sg0t3VI3EV/zZ347t2bTZ0JEdncDofIPW5ylt9Pv1g/J8hE8N
         OiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499079; x=1776103879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6TnCmX+3/CCMvkLoaDVEag7E8oCzFpXmbhOnswXUGMo=;
        b=MkE+56EUXDwanVokfn60phwMA6uoHs6e3dcpz5tVn5xRrKh4geberGp5r6nPi9pymr
         7Vss5oiZ+OwZIAzdRyCpiHOMLwHK73f8x0jR9TEw4fKn66dnlLUjrPi1/alj2s/5W2mx
         3giPOa/3EL7ZrrzqV7DxSpoukIXfs4ulloXBg8hBEtua4WAcr1s1E0Q7Ywf2/KdFHlDt
         B5yT0QjsrnfJOuHpBnM6zSB1Bk/qCh05t25ZXAKDMyzcWr4z8IG28k6W9FFcEBkLzB3o
         PqzdxQajYy0H8yzkSomXRilGw6R8IwvULrCutNnehSpl++LXH+HQnW7R7da8ByIkhyoj
         lXDg==
X-Forwarded-Encrypted: i=1; AJvYcCUHWxwt8hBj0qyxtwkadTOElRqT/UKnczM6mk1LWprDyEvLjzL7qJ9Qnbw84xydVgmIqIXk7IQY@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSTnmcKh47uOvksfF9eKcObGxwwThEFsD1mfADadLaJeqLc3s
	7MosEfIo2IGyoPEmeWsIhicckfnQugxOwPw42xOZ/4fI7aoo91Fd1eKa
X-Gm-Gg: AeBDievWg4r9QlHHjrvSkM4/X/ugmQwPNV2eHYqdCz5DCfUSm8AE43pC66eycoj8Xsn
	OtTxQS2nR23y3ato1KnjJc/ynQMylk9V8xEoIu1KalQrkxpJcpN2ogsma4LGpcjkJM16+0Ky0/j
	GwF0o2Z5J7N3o5KR+z7vJ3M1YlKCq/12bzIPj+5rMHUQxBpfTBrNoEfKp4+bFZy8zIf+clYfHUa
	AtzDigtZlLyCzaVDKLk31hQsIM4yWx3e9dlhuwZKDzsf0QIODqv7QaHRWoN4ql1OvirWogGWRFZ
	KrrUGiyfqzb/LX9BVTrOphEI35Sn0x1mfHukM30uU1KpGgTLJcaqHw4wM8fIxF5CmeHQZ5mlvmB
	7uKKQ+IqAVOrO+c1YRgNaixJWtfjkC0zYGsr2hj1wCam0n8LTJLoZuRpQMiwv8bUCzdsw0X6gJ1
	VnxbbDSwEJGqGBgDAU5uxzxQ==
X-Received: by 2002:a05:6871:2313:b0:423:6559:ae4d with SMTP id 586e51a60fabf-4236559b3edmr2499144fac.37.1775499079203;
        Mon, 06 Apr 2026 11:11:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4232eb3d0e4sm7345417fac.6.2026.04.06.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:11:18 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev,
	bhe@redhat.com,
	usamaarif642@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 32/33] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
Date: Mon,  6 Apr 2026 11:11:16 -0700
Message-ID: <20260406181116.4053796-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <80cb7af198dc6f2173fe616d1207a4c315ece141.1772711148.git.zhengqi.arch@bytedance.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-15177-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98E873A60C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  5 Mar 2026 19:52:50 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> From: Muchun Song <songmuchun@bytedance.com>
> 
> Now that everything is set up, switch folio->memcg_data pointers to
> objcgs, update the accessors, and execute reparenting on cgroup death.
> 
> Finally, folio->memcg_data of LRU folios and kmem folios will always
> point to an object cgroup pointer. The folio->memcg_data of slab
> folios will point to an vector of object cgroups.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Hello Qi, thank you for this series!

>  static void memcg_online_kmem(struct mem_cgroup *memcg)
> @@ -4949,16 +4985,20 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
>  			gfp_t gfp)
>  {
> -	int ret;
> -
> -	ret = try_charge(memcg, gfp, folio_nr_pages(folio));

While developing on top of mm-new I found that this was the last caller of
try_charge(). I was thinking that it might be a nice opportunity to just
remove the definition of try_charge() as well, maybe as a clean up patch
at the end of the series.

I see there are many acks on the entire series as well, and I don't think
it is worth doing a new version just for this. But if you are planning on
submitting a new version, I hope that you can consider this.

Thank you! Have a great day : -)
Joshua

