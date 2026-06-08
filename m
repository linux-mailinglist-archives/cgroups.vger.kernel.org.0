Return-Path: <cgroups+bounces-16741-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N95zJKkIJ2o3qgIAu9opvQ
	(envelope-from <cgroups+bounces-16741-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 20:23:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E366C659ADA
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 20:23:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fk0ahr35;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16741-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16741-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF792320BB19
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37471379C2C;
	Mon,  8 Jun 2026 18:01:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6937B014
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 18:01:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941696; cv=pass; b=DuI9X/zTr1keB3duMw5Z62T9HEHLvK2XsRVSojwhXk4KOwKsU5ZkJa4ILaiS2uYOkzB9v4cNy3J7XNCEInrflOe2YngVkW0rYzO1BDAxHlV39zSFUFoSfqp7mgA6KZUTVbUWiOq6yNEqD2ISd8cp0GyqW9h6ecGO3O1r012ai6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941696; c=relaxed/simple;
	bh=6UoX/xydv0CvknQ1ef5QoOdvD3AYDMennvM/Sj2Oa9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDP9I2M7SVbQ0iF6PA57zi+XC8nxlRfcqDCiZR37H8i3QWuYDRwph+kdNbjHnwKDJdrnOJsH0ScOJhq1g/1PGkB9hsMKDsFLbhPv4v+wNZzK7+YhzW9tnsF9k1wVc5ObH9bo8LlZaL46MtJq99EHz/0uIgyI4BksgGdJg0qsLpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk0ahr35; arc=pass smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so30749055e9.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 11:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780941693; cv=none;
        d=google.com; s=arc-20240605;
        b=Eif9jZgNsnPTDSvcPhqwSOuFYkOxak1fuXIMUx0L73nTxjGr3z9j4D30V316NDOGmm
         Hlmj/lIXZ5788+vudbZ2dfk0X019GKhsTwOQs/zH1CNQ5VD1h6uRA0HOP7YaTw4HbCgL
         9+T4H8A5Ok5RSxY/Vj6d/rUq2cyuFR5o2UC4i2OPdjMecCFa3Ro3xM/T9Dk2z8dMURg9
         g3jjbXILBQzMtxb6ZFWEp8yVEjhZAEkitiJ/jBANJyOnUinduNoku5gI2CnMtSEKT/p0
         E3yYtLeFz4n+IM4QpMT8vTW1YhfevLQXoZ220Z5cxvdfNtUKrBIp6oAqJHs+739cAGip
         TYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6UoX/xydv0CvknQ1ef5QoOdvD3AYDMennvM/Sj2Oa9g=;
        fh=7+DsVa0VSBcAbEZLZtJ3MMIwwHeai6HWyS9pJlxAu+M=;
        b=UwdfvsYjOa5Hl6VFdJjPTLgBglfRD18lK4X+iWWR0BLgX4lAVSGhazq4y5LHqF4a8h
         RiMLhTjuczwJCisg5OvgXhtUHvYhPE8crCuL67ikE4QsTKYhpS777oB8ZDZUj/VQHe4T
         ay9iYj0q2eJOTRi/jeEAFsqxA4IiLprLjmWP7b/Y2PU0CtteSZn1tbJdSrGnDtCRY8Wj
         0bYoymHNCt07peSZLDHDMZU9VZRHEvCs/d9hH5CvkRhkrO6FgUxQMKXWvT5/vPjTlEYB
         Bw3hsPlH7ver4vmyhmqE6ygB2LWmTdDNcpKwe+FlIEk6xPiQqUPzFntbTtzOBqa+GFL1
         vWEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780941693; x=1781546493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UoX/xydv0CvknQ1ef5QoOdvD3AYDMennvM/Sj2Oa9g=;
        b=fk0ahr35tn3rDFFqPzRXgc6PPWq14Da4OJHXGcEtq95yP+GItSDqGSqI8gaQYja5bt
         MjdRMJYN5IbHGBZDOp65Lb6rF/zN6vbF5hICtcdoh4w8UGpw1N3KyPduuWc1cIeBAZsy
         H6Vmn0yf5vJAFeSkbkoJ+gIsn00S2QgWUkZhgHNQXxT8mlrvzmreULFW7LkN5AEfi+nj
         GEWIlmVQjqAr1uYFMQoh0bkpc/7dp0NfRMlNtsgFB5NtZxAoHeOvZEkRkE3LyJO8C+Ku
         Safmj14ff5R3ee/tcUnSZesN+aWlivVUkUa/aHOKKZfihUq7y/nqGqjvzaFjWTY+v11+
         vI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941693; x=1781546493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UoX/xydv0CvknQ1ef5QoOdvD3AYDMennvM/Sj2Oa9g=;
        b=BecoCwi7AYLru1xH13FuJA2LVkhJPHfYFcbytjYRxdtNfdPoMH7U5MVfnKJwnhEa/N
         3p2HoWv6TapZUA+SXZ2+7cNRPuP2/QXdbXKh5D886acwkye8GB8oPdpcBX5xTQy8lnE1
         UOIH5DFRGXSO2i/n5zIXd966spwCVUO3o0lM13BbbReipSQwXDb0rCp2brFNWXr6nDvF
         fYb7j9ecGaziuoftDjL1rY9Wuhy2q5dsYpSdbnUxHWDPYyR/sfbJi4u7yJgG0f+ufq+Q
         KtiuOdpZuNSoHHOw5l6UYYdt9jlOmPZhB/Dffps/wdmTCRWPjj3jjdOhqhvBbqxF9QCm
         mPSg==
X-Forwarded-Encrypted: i=1; AFNElJ9RsHEkxaew2WV6PXeklO6G00phNVMTRhrXJJ9YdICimAC41ut7ypwS60dzl/5PE1ILtjDrU5F1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7f00FiYC6DYVQvBp7GmWyeBEDnpwk/R0+/J77LYSjyKXA3R0X
	HKOV5czNalM5wFoV23/nYJrcMb2fIe1HCixtkpacFyzOLM2loJ+730HlIuWblyoW/YvpSCBuUoK
	79jzv/MgFVn2vMDYo2BNqkRkt5v+eIMM=
X-Gm-Gg: Acq92OH1uIp88yV6LeQswgH8+WZM9Is2Un6tCxwxwUIHlbmg4dISwM9MFlw39DbO+BK
	iqVkvAbxXECHX7LcTHncDuDuUNxnj8uTTjHL3tq9Yk6EG4avHOrOneP+Bepm61vke64tbhrZGLn
	dQ8nEowAb8ZbpshiTNn90RJK0lzHScXD7sxSnRUHYYhC3ufO0TOdtFRSG5rbYw+YAD+qC7GdEeP
	M/pMvnwPvtzTSsUYIjmvIjLvufoyERtERsdnliUADUawNkFmr1ksFkPe5eLFTOOkwgHPR1aotXq
	a48X2mJsiwaQqwaulEz/rD/9BGwntHe3HoN9/+kL+LTRjvfO0Q==
X-Received: by 2002:a05:600c:190b:b0:490:9804:afdc with SMTP id
 5b1f17b1804b1-490c25ff35dmr290599385e9.23.1780941692853; Mon, 08 Jun 2026
 11:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com> <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com> <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com> <ah9i3uhh3PFiS0Uk@google.com>
 <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com> <aiBpibRNi0BcM1Zu@google.com>
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com> <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com> <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
 <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com> <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
 <CAO9r8zN6VVZz7dpjNrh8n7wbLkqcrsROPm70MQQxO49HJSmMFw@mail.gmail.com>
In-Reply-To: <CAO9r8zN6VVZz7dpjNrh8n7wbLkqcrsROPm70MQQxO49HJSmMFw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 8 Jun 2026 11:01:21 -0700
X-Gm-Features: AVVi8CfPM9EinXbnTowRrF8hGIP3rew15f95GiBStV7nPCFnW8PfDTRssPsRAOY
Message-ID: <CAKEwX=MCFbsh9ndBtR0-bGRr_=v-6bBwTo=muzd9ZSD-LAK1nQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
To: Yosry Ahmed <yosry@kernel.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16741-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,vger.kernel.org,kvack.org,lixiang.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E366C659ADA

On Mon, Jun 8, 2026 at 9:48=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> > But OTOH, this does seem like a recipe for inefficient reclaim. We
> > might exhaust hotter memory of a cgroup while sparing colder memory of
> > another cgroup... But maybe if they're all cold anyway, then who
> > cares, and eventually you'll get to the cold stuff of other child?
>
> Forgot to respond to this part, the unfairness is limited to the batch
> size per-invocation, so it should be fine as long as you don't divide
> the amount over 100 iterations for some reason. Also yes, all memory
> in zswap is cold, the relative coldness is not that important (e.g.
> compared to relative coldness during reclaim).

Ok then yeah, I think we should shelve per-memcg cursor for the next
version. Down the line, if we have more data that unfairness is an
issue, we can always fix it. One step at a time :)

