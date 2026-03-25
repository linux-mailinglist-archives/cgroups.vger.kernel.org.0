Return-Path: <cgroups+bounces-15034-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOgrIx5Kw2lnpwQAu9opvQ
	(envelope-from <cgroups+bounces-15034-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 03:36:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277B831EBD6
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 03:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DCCA306BE34
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 02:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D69428726A;
	Wed, 25 Mar 2026 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EurudgTY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065221DE894
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406144; cv=none; b=pQiN+7mYhXa/Yb4Ra7PQeQplMmY6ziPvFZwmp3CwKYVepLtdwXHOjAHQNv6huppmXjYtdmvF1FINZSWNJH6kWd2qh+nihXFgI7UwSKAVQOmnfuCtga+2K9DHTm1IX4joiEYmJs93B9pSdLGl4RVAw1zkIAk07rrSfyCTNxjnluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406144; c=relaxed/simple;
	bh=ubJF9m/wLx7bYWwOAm7o0d8tY4ejMPWhdFfkGi74I9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAQhUrSGGTgV49qqGFTV0KSO5M3t3AfDbPQAVXJat4pxKwZW/nYPeAZw70H8L9NQAP+PRuFdTmz3daA8YWUWlAT0J4Qf50Ml+yRkvqaeQmO7jOIgdW3qV0/ukCxRyfKkFOJoIu3xskwQ5UV8xW8zPSQF5b72vAfM8seh0oiXuCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EurudgTY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so4355069f8f.3
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 19:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774406141; x=1775010941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/WqiqBCLyiLY/v28qTyeW3QcaRTjQUhA8ri92uqPms=;
        b=EurudgTYj3bgYiWZTc/rEzyiUkWBbjOsAiiT89wURxO/FYynIbN13FcNHNxXUEpLH5
         /Hb3dxM9wI3LWT6fQ5036QJudRU29qe+LzX3WYY+DrnqYjm50GmyAGBog6ncaWRbumnQ
         j9Hw5HpXl5ug1Ipp+IKmtX/y9qy9vtWQbd286QzAADbonJ2P5qDII+qKVzKMvGwhErgI
         A4RwRjBShlN9WqEX1FNtyhvyq2k6x3DhqPez5rTFgr+EWTs1wEJ7zzb/xtyZKALiPudX
         +JX6EGkr84JxVMtmzypATXAPr5qWwTj6xgiW2sFrJCMJ3WkV0VqlYIFSxQ7AyLWkrz6F
         n9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774406141; x=1775010941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/WqiqBCLyiLY/v28qTyeW3QcaRTjQUhA8ri92uqPms=;
        b=UxakMAiSdP4UU3KArlK3XTvC6Y2m+TgOtaLkQ2LKOuyEZMFIbQ3338xEoUbPIhBqJ3
         IUvQ9NU2ZlJdPFWqJa6qGvkde1N0l4vZyp73Iz3A76xoo19n/JLxsIv1JOirfdJzggPx
         IElweYfSTCpw49AObC9feAZoXXpnQ7eywrgrobsSLrSl+COVRYZlNC8JqrUlZfc0L9wD
         idzQHu1pTXchcCuaFue00u+KXjO9WRnS+1Y49DzDpeihJolLyxHZXaQ1sebfL1EMGa9r
         tKrcBSSnJlv4WQOG/ajuzS295ga3jQdY7Low+6/+evfgfk4gLlyutcNyzDmLPe5bdpK6
         LafQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqFmyS0JMVAIjdu5ShmRu8Ojlddbir8CP77mk9LIp2NvIO5cdBcQ+tyHFsprS/x9oZF+NDovPd@vger.kernel.org
X-Gm-Message-State: AOJu0YydrOaRGU6KbI5aiOSMdElL4DHOvERZcCJuCfE7W0nynYPBuOyv
	0V9AwxXxXix9psWrxOYFUxPqH5nvYkmPlydphVYn3F/verWXWj2byd9T
X-Gm-Gg: ATEYQzw2CvT6hDcPwIkhGakL3l3GQZlWEST9bkE61WITPlmNruOWWy871LpP82uM22v
	KA1hfaNlvcm3GBXHAqn9FwCDzDmENySVKrOyz8yEuUrTms7MHR/H/SVNNUjon0MFm6JWUOt1nu/
	X7kZXgwtKB4eAcxByOBAyutgPa2lgitXEuwxchMqOca+L7enmxZdW2Bk40HfFSmqd/ZLc1ia3xP
	FU46A8kMwLJnfzsygIIogaqD88NAqu8b/JtM2o2xMWWhlZVyvuvFHL8gEsSZRlEjo8GykEXq0/P
	VN45ZCh7sQDRVzISqY1LGycUqanGTvDArZmIcIA9UIkSVpx0n7uphsEUuEFaIhKfgdCkS02MbEq
	DkqHQa4vkAIhnedzETjMXRGvt80OdcKR22wtb6txlCm46bXk9vYXSdQFi1LifU9pgOYxfJ7H2Qt
	XM19knXpjfrkkE0VlfQX+mAxj/VaB/VA==
X-Received: by 2002:a05:6000:18a8:b0:439:b440:b8a2 with SMTP id ffacd0b85a97d-43b88a0d156mr2181278f8f.28.1774406141184;
        Tue, 24 Mar 2026 19:35:41 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43b6470f902sm45426571f8f.28.2026.03.24.19.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 19:35:40 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: nphamcs@gmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	kasong@tencent.com,
	kernel-team@meta.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	riel@surriel.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	willy@infradead.org,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Date: Wed, 25 Mar 2026 05:35:30 +0300
Message-ID: <20260325023530.222944-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAKEwX=MgoPmiFdBQXK_4=XuR-8mVpGr+3Ku2MfjPmHCeuUdGJg@mail.gmail.com>
References: <CAKEwX=MgoPmiFdBQXK_4=XuR-8mVpGr+3Ku2MfjPmHCeuUdGJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,tencent.com,meta.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,surriel.com,huaweicloud.com,suse.cz,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-15034-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[56];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 277B831EBD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nhat Pham <nphamcs@gmail.com>:
> I'm aware of that work. It's an improvement, but my understanding is:

Thank you for answer!

Also, is it possible to have checksummed swap?

I want to have checksummed swap to be protected from disk bit-rot
(I already have ECC memory, so RAM is protected).

And hibernation image should be protected, too.

I tried to put swap on top of dm-integrity, but this is
incompatible with hibernation in mainline kernel.

-- 
Askar Safin

