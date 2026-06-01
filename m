Return-Path: <cgroups+bounces-16524-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNzGAq63HWrKdAkAu9opvQ
	(envelope-from <cgroups+bounces-16524-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 18:47:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFC2622C65
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3F9530170BC
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0183264EF;
	Mon,  1 Jun 2026 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jypdayeo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA923290C9
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332456; cv=pass; b=aCu1R/mB6nh0q9pPcw6zwHL4yApJxGGu8BCZ9Pe7aISbIyt8LhjOX2xq0VUq74Oc686usQfLilMLaDnjZCOQsPOP2G4qYOUSFYY8tdAoFUP+8VgNcU3YKCupybpngshxxcns2YjBEbXsReIg++5q7lX98gKw+n5T18WKfOpgkUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332456; c=relaxed/simple;
	bh=xo6AraTzJMTpgSfCYcj4/S3X8D0rbyuKdNz81jBZtVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaGjnG9GoOIMrhuowkj6nmt25YhPOwaGYxpXpDWmVy4s1Ag7Kq/r1DA+rXM8iORaaWKSxe/dzy5decrKl3drAE9FFGt/R7rm4CVItt/970P3jK6LKt5KPcj0lg+AYXEnvjZ3pCDsJOvXjfNc35M4mU6G1o4MoKTCxg4LVufm4iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jypdayeo; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so115894215e9.3
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 09:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780332454; cv=none;
        d=google.com; s=arc-20240605;
        b=NZZwUOUEOamtHsR7q8SQ0FWu60m/yu2zFXnAJGOmzVzqmeUMj+pZJ+vByUGgwfHX0t
         5Kop2j0HUY2e+aHGx00QHB2wH/vNQypOuTEgFg8/9c2pjTKW50paGNW9RyBtZEaOZZzN
         2Qq68JegXPzcMyJ2tUYyN/addV9W8sWAtqkaXyDQZ18uVz4RETHq8QmZm0/crV6V39oA
         NBb7W3oeUmnZTxEu2MnSWwORnL6SaZM4tNDHyVbhZ2XBqs8Q9KsgksqivcChzszR70jG
         dadb63KCfui5mKZ2fzH8tkvJtv6aX3Yo/vATzpO94EuNfthh31F4guVVcslOs2ujxy0Q
         vBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xo6AraTzJMTpgSfCYcj4/S3X8D0rbyuKdNz81jBZtVk=;
        fh=YOmHZ683Lwd6DTJjJ0HvmSenRYG5X0nH1e1b6MvRugc=;
        b=ZXFE4GqELaJ1D0yGdaFvbyncIzhpMF7i8P+/nH49IVGdpkeozQm6XGTN2cVGVT+U1M
         O4DyHyiMRMQOs2sQHDPP6HgBhDNZ1b3q+PQdma7rLNtpBbJXD+NGWaBSwkTV+Z+DmFGX
         tnU23I0ugSlUOk5kIvNlbU6AgsGMJGP79AzykwmydFs9HqOERqGKl1QrkOiUYDbuutxc
         lUmSg7ci3k7dcnveXHzDwZVQAu7d0xw+0i1pl1tEyxPRfzpvy6eIge3mjxyRi1ix2nHu
         UGQJQ1nn5MQ44/0tEgZkfEjzBO2vnRowg13/03YmsKFb8HD+bTxWmmVYtRIqfMJ8F8eX
         N7Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780332454; x=1780937254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo6AraTzJMTpgSfCYcj4/S3X8D0rbyuKdNz81jBZtVk=;
        b=JypdayeoiJWuYFe2nD69Ux6T7SQW2QYHP2p9TNsPlsr9yXMJBiA5+2TUcQy1NsSmc7
         KhANsa97HrfUKSybVgZUZY7IXf/fM0ohkoC9105+f5V3TZAXd/WczuBJMNTlBBP8FtsV
         ogBnhdmekAID+/0klZ057opDcbp9fl+jp5+razntat18FA//6aXQPJWb0bM0jSNGid3+
         cSqVegu6qVzYoqNjrr/kl89UH6adpr3jV7jCpebYWxel0IoZqAYEnWn8IdmXitgBBDzC
         Xk0cYY4WPpjs1jFZ4J6Qdiy5B6CrO2IXbBeWyJ2lHcqRYjzQR1x0qV4Un0DEPMDOakbd
         d7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780332454; x=1780937254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xo6AraTzJMTpgSfCYcj4/S3X8D0rbyuKdNz81jBZtVk=;
        b=r5glZrgF/vuR62CKb5TrS+PET8oR92IeCqzGU6GuoO8aTGnMEZ4kNRaV3skpdJQdQZ
         qbWubtoybDJi+3HUsqII7Xu2Z/rA+IBJGgFFe36d3SlcJxd/rq8mCKCJYTFfzoIM+f8Q
         N9rn8IHlAGOho5hJgfZ0qsg/oUL8+dYCeHqv+ag/Eccml0v057c3P5kQP1CX/zMNSVEo
         NleigrcbvnaYB4jm+ADo5j/Mj7gDec9rKL1XY3n0l9gPMGcYuiosSkg39ELt2aUDBOmM
         QAfMsvWzYUSsgyOEWcpC5eSA4DlL4Z2npsm8JHS8wCBvxJerUnhhiBb4YHqlELCMXjI1
         Z6tw==
X-Forwarded-Encrypted: i=1; AFNElJ9YsLPj8gayR2agl8KX8DjnD6DCYA2FGtbOAWUv4oYL8oUzKY5HUNSbhY2giiF4zfrsgLjpSZ0M@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaJdzLGjXrDKoW6WgalbMqQRU9Ly5F4IcDhTtlEueDhZZuqPQ
	Th1W6SY/ZyTjmS6jUy0UQwAPWeijC2j6xy2W5BObyE3jqysUa7bVRA0322tCCfnR9+jgngtaqKf
	ACm09SCnHEP4H/S1OKFCscwly0kpZNH0=
X-Gm-Gg: Acq92OGHlDG0jtPFMs7JM3HN6n4pA/AQYpetr9h/bdnBMpJL/Y7a9ksLn98YkZSBT9K
	lQ6Co3zQMKu6mfd7pQJEAv2htFnSaRCv/boxICDb6kIbbQZgGTn4IiKo1Ri7vi3hhD6WKOdOTYy
	LMC7CJRg3wJeRBY9Yrm//xS78Vs+xlcb7yxXzV5h5kV4XfYXkWvEes8lNfe6H3bwwLUwJfIwZ2S
	NKhz7AHop5Gu+Jbxdn/YCqghVhaWJaiQfapQ5A9mmE6fshEWs09rwIuldXPVM8cvd+ur5+x4cad
	Ji0KLBVm6yyREDd+9g23va26zWP2XlN5TQMa6+qfUNg0I5zv+6BAp9uSK5yg
X-Received: by 2002:a05:600c:a214:b0:490:958c:46dc with SMTP id
 5b1f17b1804b1-490a2953d0fmr139013995e9.17.1780332453810; Mon, 01 Jun 2026
 09:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com> <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com> <CAKEwX=M5KiWc8ZZTEXCXtxeBrQho3Gs-JnKmBB=YNUkp=WXaKA@mail.gmail.com>
In-Reply-To: <CAKEwX=M5KiWc8ZZTEXCXtxeBrQho3Gs-JnKmBB=YNUkp=WXaKA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 1 Jun 2026 09:47:21 -0700
X-Gm-Features: AVHnY4LNMMUatp6JDueU4CjsI_pQhdw4wgollhGHxH_yjG13hM-7SQCVtIuqd0g
Message-ID: <CAKEwX=P0aRy6cep1GoEVxRejm03YQNis2VNgY4+F66BzDPPOdQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16524-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9DFC2622C65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 9:44=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
>
> TBH, I think the spinlock is simpler at this point if we need to do
> all of this explanation to justify correctness of cmpxchg :)
>
> That said, if memcg folks feel like an extra spinlock per cgroup is a
> bit much, we can go with the cmpxchg() approach. Please include a FAT
> comment explains the compxchg() approach's nuance in the code though.
> Speaking from experience, I will forget why it is correct 2 months
> after the patch lands :)

Another alternative is - can we repurpose any lock here? Locks seem to
be per-lruvec or per-node, unfortunately, and we need something
per-cgroup hmmmm.

