Return-Path: <cgroups+bounces-13379-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD96C+7JcmkzpgAAu9opvQ
	(envelope-from <cgroups+bounces-13379-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 02:07:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B89306EEA5
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 02:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B45301AA70
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299FF18C933;
	Fri, 23 Jan 2026 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMG8EFST"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB535FF5A
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130454; cv=pass; b=ojS6iuogQxtgJMMEDZQ0O+GlitIavTt11XbXRSPmIauX8KJQnDl4o+HRUxIMaCglJm+c50iSkFA5bj2Mw1xIOgXL/V/HYprpiz/URQEuUDvkr/BcDBbUSAqVxuC8uDzWyeYPLHmxjoh+dzbLeIAgGRffSOcJM0JIayMMQNVz4m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130454; c=relaxed/simple;
	bh=Dlk/+7JjJRURIX0qL8IJW3BrR/Y1gihJvjx/pvahAUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5131IXbREkzYVpBVuYTtq1K3dPJw44D91mTZ6CzngNP9O4sgiYNFbwYh1UgK6uoI2yuJZzqhaITRt4zI1PkHW6L3rM3sMZX5hjtcbx7Qhi7UUiPXKW9khhJ9rYcjHY5wuRuSwJYXH160jRpgXu0nhgmVi1n4g2Y1s/IeDLInNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMG8EFST; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so1478130e87.1
        for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 17:07:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769130445; cv=none;
        d=google.com; s=arc-20240605;
        b=kcP/gBbQMurc8ID/G9GkHyHTP4I3UTYotK5G2YiHNXVOiUV3wPr+qJCg79iQSN7z7l
         ioxgdOpZV8LI2IaYIQl2YmPWHsgmQE/CX9E5Lkj/wHRNrHAQvujDTGxoXVp5G7DBh5hj
         UGLqPNmhBbzkCuTMK3jY19LDFshf/z6qxE9n6d7fDonXf9N4rzziCWxU1j3qhehFOn/n
         jr3SDxLNsEEE42WnuQIettd5J72B/l1dy5rPpMRubq7lu4OPb8uugPDPG6X5RXFY7YlE
         T16DLCEy4JW3kZIcRjJUfbZXlddJddppzx2zg4QWRpqKl19+cD7dED9KBgfl90J4zc9h
         7WgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rGyoSW/WPLql4+7CUc24ElsVpc6sE1CN7vPApzpWu84=;
        fh=DVYLJpFLxvCf41oGrRra1jCV2DgWEhY23sjOKo4th18=;
        b=JoVYTpXV0K2tzqD7MY1PuMbh/mrsZYIGYu9HO3cwOM/tZTy5ujKqdqxs5yaOPREOKw
         VQrDhlRZyrarc4WeFCUkUfVFJ5GiWZQoNNRHO7/pXgVWWq7XRaFKkgAo2ysCjCQI5gaO
         6IKseqLSzbF/XoXCdjvjw7VwQRb6eyDSAdc58+FpvenSGpEOuvQaqpZfGeB6l7ms2RhF
         Qs3YBU6nCbxUKfg1uex2V+lSNdB9zq+36yYPcOKy9COKLXYaNM06w/xrKzABpUdTw5a5
         5fiAWRYYDko/D6qsQX4FyzSduIOhqKEM6FdQXHBEVAPgfyqj744bWBOCOVJOqLcDC3ZM
         d/MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769130445; x=1769735245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGyoSW/WPLql4+7CUc24ElsVpc6sE1CN7vPApzpWu84=;
        b=NMG8EFSTaE5jvQXZzO9zy+yWOOvCgTNTbcDJBQNMneKFEVWq0kclZ1ctECg8zibvWH
         1PEHVkA9J/VnC6cRetAXCaTA3ljVAOFNPd0Q/J4S+XlPM/62fqz81ZouB95tMYXbt/Fc
         gz/cnEPDTKAO7rJR93v4PRffNcOC+yxQcmPHw+2dIVvd/REI85Ylebej69THHVPh5BFR
         LPlKw4J+raYGKzTnVr5a73g8UPPsOXHGQ3geg+nXh82ABn1f+K+y2VpkpztauQ7lSbvp
         lcjaDPEtfJazjinX3Vzgo33XIb7l0fUUpAEszQWG9ozdRci3PQO9RLJ9qNRg+vDBA8xk
         U0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769130445; x=1769735245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGyoSW/WPLql4+7CUc24ElsVpc6sE1CN7vPApzpWu84=;
        b=NSEHmnEa673steD/Dosde9IO8d+AopH6izX4SotQytCgD/St9trnxo8PUKon8+9Uqb
         orHdoHVtw0ihsrYbdPvL3JaQg3eXV+1qGnt5bUS0+B0Bd4vp/vw0W9zcnJvejYc8W0tg
         u3Ni8s8r6LJ70Y70u4eRedut79qw+pUnDacC/7U116O/fXT/u0XvIw5njK3ut10pKUXO
         yfgxTswmoasB7GNMXmIG0Y3XLLJvjmSav6idBNcUqr6RP13HynyK5qAEzi3WF8EteVhn
         YE1tfXhSfquv5xKU6DNN8b/He3n9p4FSlAbN/q7ENMCiIGaWQ5J8LZub8OOrOVXOlux1
         A9YA==
X-Forwarded-Encrypted: i=1; AJvYcCU4AJPAFGLa+aEZX2cjErsC5dNi+5X7V3RG+6/qXXvdJTzSoJMCPYP7WACJZ+ASzqiMM3W2pBBh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiv7mnB0ODmnwxHYbS1RGf/Vfq8HsXyHvj9jX2uNzbkSR9OwP0
	0p5dKQY4i87cr5J6P4cRvQ45iWjvCOCO24dm1V4tQERiEDt6/FBZhfUST6uFCmCURd5YaHcoi8v
	upxQtP544Q93djZZCkd5rDXleBFcCv/4=
X-Gm-Gg: AZuq6aKx8q2KP4KIR7JBo81I9UuGM2D4NNb46APMleXtDWhSgwiBtjGTTSAKOtibIz3
	qAI2BDnzM8zbzvCOLNHvkeZ0/3knJ1SifLYBsmoWtTZ4ac9AlA5EPdXlZfz51ujidGJFLQzUw8S
	3hefLWzuhuEBrSElcIymzp/kAj/wL9JB79A5OZTOWj/21cAJmE4XME8o8t/X4Oc3/mBfrEEp7if
	FTSVfrRvtxenkIQOqaoA6bMIbcmDOT0C0BzNmi8HPBn93CvvdEQAuTqgXftnVZCvTvt
X-Received: by 2002:a05:6512:3408:b0:59b:7c03:f2f3 with SMTP id
 2adb3069b0e04-59de490d696mr399706e87.16.1769130444163; Thu, 22 Jan 2026
 17:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110042249.31960-1-jianyuew@nvidia.com> <20260122114242.72139-1-wujianyue000@gmail.com>
 <20260122091351.0cc1afd5d419fafa1d98b32f@linux-foundation.org> <aXKRIOpDrZG37_wz@linux.dev>
In-Reply-To: <aXKRIOpDrZG37_wz@linux.dev>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Fri, 23 Jan 2026 09:07:13 +0800
X-Gm-Features: AZwV_Qgio7l1Tz4KXAornt7DlVb5tk0mkWvHJrP1iqEKzzaPj3CCOYauPVz9-7A
Message-ID: <CAJxJ_jgGCL8WcyAO1iyF5Eu+6JtcemAPGs-WMFAaHdaM8V3uDA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: optimize stat output for 11% sys time reduce
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, inwardvessel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13379-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,kvack.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wujianyue000@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B89306EEA5
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 5:12=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Jan 22, 2026 at 09:13:51AM -0800, Andrew Morton wrote:
> > On Thu, 22 Jan 2026 19:42:42 +0800 Jianyue Wu <wujianyue000@gmail.com> =
wrote:
> > So the tl;dr here is "vfprintf() is slow".
> >
> > It's quite a large change, although not a complex one.
> >
> > Do we need to change so much?  Would some subset of these changes
> > provide most of the benefit?
> >
> > It does rather uglify things so there's a risk that helpful people will
> > send "cleanups" which switch back to using *printf*.  Explanatory code
> > comments would help prevent that but we'd need a lot of them.
> >
> > I dunno, what do people think?  Does the benefit justify the change?
>
> It does come with significant benefit but there is no urgency and we can
> definitely decrease the ugliness. JP told me he has some ideas to
> improve this.
>
> Andrew, let's skip this patch for the upcoming merge window and you can
> drop it from mm-tree if it is a burden.
>
Agree. This touches a lot of code and increases complexity, which is a
significant
downside. If there are ideas to improve it, that=E2=80=99d be great.
I=E2=80=99m OK with dropping it for the upcoming merge window, and drop it =
if
it is a burden.

