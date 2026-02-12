Return-Path: <cgroups+bounces-13909-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDfGA7URjmlF/AAAu9opvQ
	(envelope-from <cgroups+bounces-13909-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:45:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9461300E2
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459DB30515DC
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23626AAAB;
	Thu, 12 Feb 2026 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myiEB1Cr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BF1A0712
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918318; cv=pass; b=klW6ZyN4c3Vl2Vv2a3UPp5CYevqVGgWNwe/lmrvV2GwhQ8n3p7K/0tOaolqmcz5npVU28SCJByHM9Hfbb1VWW6LBTxAm4p4/7E1uC/sDwX0Ztsvu5ZSgRT101YUmZWMWFU2eB1IBr/uZMSU8C2RsQrZF149jt8tDfDO4Ay5TXu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918318; c=relaxed/simple;
	bh=w/EHFFOB0IIr1DJv5VOrfT4oZYq8P3Ee1hiCpoYhkvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYVUN7n+wgnRul3WCK9tREd2kYvGBtmOgGf/OkfNcf99RKjXqVy1E2uiWOBCzDwIyhjiaIYoTjrPxv1xzDZJcjGVU14qqgj0DwdfFV9B9iCE/tfBf48APFga1IvCiysA+3B21nyxkWXXLh4uZgxSXCCWNQPb0ql+UgJrCHzpsds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myiEB1Cr; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4834826e555so969285e9.2
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 09:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770918316; cv=none;
        d=google.com; s=arc-20240605;
        b=OXw2kSzb48TYWmhXCi3BHzU8kiskofaDsyxJheTv3cdLHbdwQSHQEedw7LutgNl/xI
         oHID845EJZAUm8i5PFiolj1iJam3vEcPhnbcooWa532TPPYd+T6YKOv+icriFeuH9Ru6
         UrcuDZKkj2OyKRLzaqP7hbsw08z6f/piZqah/Mn8gCe+IhVxNok8ub03FawClnrarvXO
         D9fUUzUDyFFztPqyw3a51sG/Evmld1AE+9mo1Y4NdX1+Cvh/YEcISUQqkYHENrSHQLo1
         XsamCf77jkI+kcl05kP3aK61FPGEM3XF6tevjSy1QbeT+IMyZqcPn3mcDMW/zxqx4eVD
         D9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w/EHFFOB0IIr1DJv5VOrfT4oZYq8P3Ee1hiCpoYhkvA=;
        fh=H56W3STGOEjAC2hYOaKpe/9FppMSvfqz5S6uxiROyr8=;
        b=b9uoJgoKsYImBHs/eXy2zB1/463mO00cuG8TCq8+KH9SQAy2KsumgJ6aYdu8nVDWYj
         nSUVNuEKuMf5/onpE07HspRAczciMxy2kIWada1h/pmye7hdJSmg+4eEpusE3Lz8xtYe
         e4DzCL5f8GZq1tIrhKPYG3XothHepRSaZyOUT8NIAW0krGEnvRd58Mj8NBQPTZR6Iar9
         wdp2mzlc9xy3btySGCAc7+zIMCNE2iYGOzBfOqjcV9sHJOi0TY0RHCZp9uofbm4F6i57
         ps9nIDDM0JlrKcmOY1a+rKtke/LQPLa2f3lD3wegpZ1OfaQiRdpfk65wlkRov7A2a3re
         t3Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770918316; x=1771523116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/EHFFOB0IIr1DJv5VOrfT4oZYq8P3Ee1hiCpoYhkvA=;
        b=myiEB1Cra3pncCKSatOdOo3nCHh2EKHHvaEvjt5M0RO85tbxuO2BB+idSGLfCbZa03
         fi724Q20Z6Gr0wB12cmOIePsSQXSOaIRYituYRKmu47Gg7fG33gLMy738H48YQLkDFu3
         o0t+JymUWto4KlsztaNggeZhcopBj9CUc3GbaC04EPYQpYl6Z1bDuphYCfeUY+nDghZ3
         3agOBerKCpC9TAGWL9AE+b7V8q/SYumWaRvifMWQ03uG1FOyp6ChVYaSVAbB1kjdHnyt
         TQq1OfNabs6Dhk468e/G9WujYLdOjA4e3zvnC4O/aq/8IU6vsruAzB8qbC2bWwV4YxdX
         PSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770918316; x=1771523116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w/EHFFOB0IIr1DJv5VOrfT4oZYq8P3Ee1hiCpoYhkvA=;
        b=KZbG8qNAS1fbFY0KZKvs9EXJy0pMRxdxTC0/kWOBF0kM95wIJew0GtivrhoP2DVQcS
         zC6m6n97oGQL10GakcZxaqBLDpIO39OEVp8W06WKCC/POG1Q7+Tkwn320pL+2V7wXDTh
         Kv6dBg1hs1VePwxZ6DHUWcctJhf6mrkUlfX5sBLFoyzxqVvHHudVKqz5LiYODeqDGSO9
         NucLD25pWKEGW6tf61UDYRX8sKc1xaXWjBrlsipaiiyQxOu/+zP7AReZEyECPRnqNVaJ
         h2CTFfAaka3Xs5oY6S5fSe3QavNU+FePGs2kgPL+6R3dW2wNRyUFCkiJWy886kTIqOsG
         ufuA==
X-Forwarded-Encrypted: i=1; AJvYcCVL2eWz0Ts3lsjq1C7mC1gABiTfH1z0sKwQ4fe8gxPV316UglW4OTik55KhjLzXsKlSb+RkSEzC@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFl8X1/yMO0VkvyF30vwyen/TeTF6k0F3onKRb6fcNy9goCS4
	XRSTpn94H0wfSRkmic7/3TTKfjwPoC8VEihuNquW3Tdc14Tn7EmPtc2CverP+4kHmSk+kkXY1MO
	TqY9VixhfpYyVzqVAjLKZgJDJchZHJ3Y=
X-Gm-Gg: AZuq6aKeJFE8VxCWn1yFXgHFZcv3G1uR5+TJJ6824LVAhm+Xvl2VrVXLjJZFV5ohcMd
	g5oLXbsoNoBJuX2rA32drv2yfWcUAaCOyYyAHxzkdITuiJYqnRfwjJL1uRArPxuM5Cj5J6l1UTK
	iovJWzYGlTQvMnewr+dsoJw9hJGjtNwuain7a8Or7eIkcrL1t2agLH8bQjuMm+yScLR7jG+zsA3
	May5ZcDwXq+z/Ay0NRtT6hbXxwP2Jbcw75jEEgIE4uLLpIOCpd3qXSZSulbmfw80jTTwBqpLEwU
	BWfFsz+2fr/SEra8MZMVO3cBB1LwtgC96LDKqig=
X-Received: by 2002:a05:600c:5288:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-483656c6081mr56278375e9.12.1770918315882; Thu, 12 Feb 2026
 09:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-1-nphamcs@gmail.com> <CAKEwX=OvuVPJzQsSQm8F+zsRgJFnbMmW2JMJbGebp=U8+jMRYA@mail.gmail.com>
 <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org> <CAKEwX=Pww3ZNw=VGZBa46NhKuvefRM7wnVuZy0aADoCoE1KSzA@mail.gmail.com>
 <3eaa8d64-cc64-4e49-aa80-a3f029d63993@kernel.org>
In-Reply-To: <3eaa8d64-cc64-4e49-aa80-a3f029d63993@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Feb 2026 09:45:04 -0800
X-Gm-Features: AZwV_Qi1_EMWOI-fIh6ISU_nJsN6lXES6EF4dy1h7AM5-pJ3Hm0yGMueZCnJCfU
Message-ID: <CAKEwX=MHx8rabQEBLMrP4-AfyCNYNi5XAi7mWeK1aKgF8y92=Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, kasong@tencent.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	bhe@redhat.com, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13909-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,get_maintainers.pl:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AC9461300E2
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 9:41=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 2/12/26 18:29, Nhat Pham wrote:
> > On Thu, Feb 12, 2026 at 4:23=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>>
> >> Are you CCing all maintainers that get_maintainers.pl suggests you to =
cc?
> >>
> >> --
> >> Cheers,
> >>
> >> David
> >
> > I hope so... did I miss someone? If so, my apologies - I manually add
> > them one at a time to be completely honest. The list is huge...
> >
>
> I stumbled over this patch set while scrolling through the mailing list
> after a while (now that my inbox is "mostly" cleaned up) and wondered
> why no revision ended in my inbox :)
>
> > I'll probably use a script to convert that huge output next time into "=
--cc".
>
> I usually add them as
>
> Cc:
>
> to the cover letter and then use something like "--cc-cover " with git
> send-email.

Oh TIL. Thanks, David!

Yeah this is the biggest patch series I've ever sent out. Most of my
past patches are contained in one or two files, so usually only the
maintainers and contributors are pulled in, and the cc list never
exceeds 15-20 cc's. So I've been getting away with just manually
preparing a send command, do a quick eyeball check, then send things
out.

That system breaks down hard this case (the email debacle aside, which
I still haven't figured out - still looking at gmail as the prime
suspect...).

