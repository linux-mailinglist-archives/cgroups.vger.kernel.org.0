Return-Path: <cgroups+bounces-17631-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 87okGcDET2ptoAIAu9opvQ
	(envelope-from <cgroups+bounces-17631-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:56:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E47332F3
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:56:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="MW/3wwQs";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17631-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17631-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57B24300BC6D
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E03839AA;
	Thu,  9 Jul 2026 15:39:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04661F3D56
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 15:39:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611576; cv=none; b=V7iLiKOMi+UjqhrWict7hTuZmqjN+eEuXr9oRQkWlwhe0CNvDmOQdKTGwTkdYqygi3+Nszg7ff1ll2DrPBl+ovIdolgWnEWKj14+7dJSONIMGhRvZ55cWzzMXmtHhouO8KHDJhl9+hW99NqQjzZwI4Kh46HncNmSTe7co1CpUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611576; c=relaxed/simple;
	bh=R07iPGczI9CMuDV0hOy0iNA4x3E3zIrOkLWW9OgU5bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFhbEast0Lrs/ZBcn6OHZkP26XvXccmfZ3iRc6tD4HG9+3izQrePTdQ7bklCEMNpGgyHWthlQXoQdf494fa+XPn3NaL3fE+rWpaWNSFn7uxMlnC5KQo10mwQZUybjOeAJyTM8XPQ3t41HvhGAkLAc2wymWUBqpWO6NhuEd+05KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW/3wwQs; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84537d04408so101554b3a.0
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783611574; x=1784216374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lXXGap0Q/LiZLJdfHOXl3AEYRU8Fj6byPx+ImpQAltY=;
        b=MW/3wwQsArRbjmfHx+GQxCpb6sE0rnlhThiXJj//cFt2f/8ukD5D8wdhC426OqIWU1
         coDhkkEQcyW3icnPBFtdEGu6nv64V1ASjWaxf8kEImoFA8WhIvzYWXCG5fIK5Fazeml6
         glcLUAuT2vjIh/U2dSYGGIppYT8sBIHT1nK6VLDIOCo+ILE0J5cJ1BA6adfL9Ka9/JHL
         J8PpRSMhN7bDh20AciNAFPBOzLspj+nFr13DYWSBM24UqISksYiE2jMpsYQ0NLXlzQwL
         V2AQ7BY9wmuZWBxGQvUlBfZgzrojL3pd/OTO9rYULPM8oecXJO0oq4YtuxlQi6UWyrhT
         mNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783611574; x=1784216374;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXXGap0Q/LiZLJdfHOXl3AEYRU8Fj6byPx+ImpQAltY=;
        b=X+TJmyuPnJwkuNlwR6/aKGQFVgqq5g6WOHLBbCptJyuew1wEZR59HkZM61R262T5jy
         65kxj/JTshuTaOQJmJJEmYYfbEJaoN5RXKIatlkT6eO23zatyYXZDjEX9N1uDuiCDA/p
         vMwS176wQwOv3rrM1YdlZ9w2RyC2aU9nlrW7xxzhF0s4jODsyH1pYLdgssXAdkS7+vJ5
         02FsRgofSTU2npjgu8nO+P7GamYdL2Y73zkNQui69FFV0Y4WbaMRqqQIFsw5jCKqw+k3
         54zmVFhk6ubLRh9jwloxmtKCXUJrwKLpnodQj/YW8gWWnYnffqzfTFd2EN0oWfAnrAyM
         Lghg==
X-Forwarded-Encrypted: i=1; AHgh+RppRbLlZllRwib1RsmdEh7wivup5i6lzSGw8WO7Xw8Jr3NrFl7O7/Y9sSsHXb/JH9T5EPb/lo7N@vger.kernel.org
X-Gm-Message-State: AOJu0YwacsyFfjwViliksjCFNpo4vjxZssQc755xmBlY+aF3bYTmHJXu
	UiIlTJ1QEMjekMAH6Ig8GeaCXbmES82Md/vgg8hB5ZXBCP5Xqgb+Hx08
X-Gm-Gg: AfdE7cl5UtXiSR0TSZVH5Dj8GNdC2dtUErKEFyYNmEjCBCgbS5MFzDzR1/GdXLd4yy1
	fB9BYzzat2cXu4BNeKFzvTDTQslwSqrEVbETWxhdxrM2YIcfFL/ps5sXutoCY+6w6WhzbzLI5fK
	J/PH6fxxM5HNPg7JzflTt+D+mwCUHcn2NN8ZS/EATkB60OXUfPsNCRKXl+VTtYw4vK1xmtNRqA3
	lgI24eyf4iOeWi2GGjfidwKTgJh+AFjAT0520iokAe6EoSavMdwsZSTbRrbkZ87yS5ojwq6cXju
	LIJ0meZWJNmNUPJGzIl9QRxY0EBbdfxOlFFPya8olpERa+cj/UI5RZoEVYrv0JyJ1WZFAJiROYo
	Yyy5jzCfs6TKmi9Te8O2uf56WKAmxnhkdTjjell+xyiHO2cBKnMA/Q2SMNFFboQH31GVeRe/Lnm
	tX3a9TkVP+euEOFdyDrxBpuRpyTT3bJA3KbgqHrETTHOSuPv5BdLfnk9Q=
X-Received: by 2002:a05:6a00:a93:b0:847:8971:87d8 with SMTP id d2e1a72fcca58-848560021c5mr3191674b3a.6.1783611574014;
        Thu, 09 Jul 2026 08:39:34 -0700 (PDT)
Received: from debian.lan ([240e:391:ea3:6910::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84856d5d619sm1491303b3a.39.2026.07.09.08.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:39:33 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: hannes@cmpxchg.org
Cc: xueyuan.chen21@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	baohua@kernel.org,
	zhaonanzhe@xiaomi.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	youngjun.park@lge.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	qi.zheng@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com
Subject: Re: [RFC PATCH v2 2/3] mm: distinguish large folio swap allocation failures
Date: Thu,  9 Jul 2026 23:39:24 +0800
Message-ID: <20260709153924.772408-1-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ak-4d67hVnC2_BBH@cmpxchg.org>
References: <ak-4d67hVnC2_BBH@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kvack.org,vger.kernel.org,kernel.org,xiaomi.com,linux.dev,tencent.com,huaweicloud.com,redhat.com,lge.com,infradead.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17631-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:xueyuan.chen21@gmail.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:baohua@kernel.org,m:zhaonanzhe@xiaomi.com,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:xueyuanchen21@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 546E47332F3


On Thu, Jul 09, 2026 at 11:04:23AM -0400, Johannes Weiner wrote:

Hi Johannes,

>On Thu, Jul 09, 2026 at 11:01:12AM -0400, Johannes Weiner wrote:
>> On Thu, Jul 09, 2026 at 10:51:23PM +0800, Xueyuan Chen wrote:
>> > @@ -5550,10 +5558,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>> >  
>> >  	if (mem_cgroup_disabled() || do_memsw_account())
>> >  		return nr_swap_pages;
>> > -	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
>> > -		nr_swap_pages = min_t(long, nr_swap_pages,
>> > -				      READ_ONCE(memcg->swap.max) -
>> > -				      page_counter_read(&memcg->swap));
>> > +	nr_swap_pages = min(nr_swap_pages, page_counter_margin(&memcg->swap));
>> 
>> This hunk is unrelated to this patch. Don't mix refactor work with new
>> functionality. Make the previous patch a pure refactor job (where you
>> add page_counter_margin() and use it here ^), like I had proposed.

You're right, that refactor doesn't belong in patch 2.

>I also liked my version of mem_cgroup_get_nr_swap_pages() a bit
>better. Please just use my patch, keep the From: and you can add
>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>

I'll use your version in v3, keep your From: and Signed-off-by, and make
patch 1 a pure refactor patch that adds page_counter_margin() and
converts mem_cgroup_get_nr_swap_pages() to use it.

Patch 2 will only keep the functional folio_alloc_swap()/memcg charge
changes.

Thanks,
Xueyuan

