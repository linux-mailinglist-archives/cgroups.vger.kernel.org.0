Return-Path: <cgroups+bounces-16523-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKskGwC4HWrKdAkAu9opvQ
	(envelope-from <cgroups+bounces-16523-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 18:49:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3D622CA3
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 674CA305E898
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57817324B1E;
	Mon,  1 Jun 2026 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zosvu4oc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D531F99F
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332314; cv=pass; b=nmpueea5uLOXUE0YrN6SlDp8MdUGrF6e8SH4nQYwAr08u5pU8IQ0pV38qeU0OjzgZjzHCcsIUkH88eU5OMX8JDe5gFCVcOohKdSi0DnV7LuzkJjEqB4FkuTX0Zur3W1jYhwEs/728vyW95X9YrR1nd69IZdUrR5wnwisbcOoPgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332314; c=relaxed/simple;
	bh=SuechEhgIbIp9Ei8g9Ubfks3HTEaKTHpGRK7meqRSP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LunFtcAqTfgTH4Qtw5TBL1ZiJkLc4YPI8V1yRP42n5jmacCDLhQHmKOvofpEdw0ki+J7pAXB8ZF9Z30E1sYxCjBzhWZ7mhYTyS6cElBmxEW650X4MxazJ6w0hci6DvPiSZbTTnBYMx+UcYbxJcPF1Srzth7BjSkYZ+8FxW02O8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zosvu4oc; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4600cbb06deso893365f8f.1
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 09:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780332311; cv=none;
        d=google.com; s=arc-20240605;
        b=bQIOGzwvC5AujZ6ZgAwPqEehlw/YvmTy0piBl7z0/M50HsoS+aK6B3P/GHlroLD/AG
         BWBZGhv7Es+TliApBTjJzRkfhcskWE0XxcZHBUVJMFe9ZJ2mMimJw0QTcyboz4MlfFpA
         4EdNVh9JXT8fX/9Fr+wIg1G1Xh0e2zD64i0Dc8LiHcbgYfelyp/LLVTHrUpvG++1uil9
         xZftMUKZsLG6FEtJkxttQE7FNS0Wyk/uwoBhjA0eCCEV+XitQybUcUah8jvPK2Ot/N41
         U3najfXGAb0nB7z/PI6W3cFyorHCuUsUZeznEciiTe9miNaTj4hYoY8RevIY0zJO4Yol
         C8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SuechEhgIbIp9Ei8g9Ubfks3HTEaKTHpGRK7meqRSP8=;
        fh=FkY0/qgJMZDARLWEXKD9x2PC953crpXcMd7DLkJwKpU=;
        b=iH00FWd9OfBjNyuKEbiNJxCBdpLAMRoFE4yN0yKAJvMXLGn461m482X4VLlpmsm5RQ
         GulKeIcHZL5XjaFARZHNOFfqhlL/H68Y/wQTnWhHJ+vJaphE8gf3a+xcNOt8vXsKsc39
         o5hET10SU6K+/g2oQemZLAUpCqN02IebXGHEk2x0BTOg5zMXBDjJ/+gg6UKkn8JvxHI/
         8dwrQ6fjja+mTn0pgJVvMEVQivSV2cq+b4AvHDRSr+OI5eW9v0LUlQxCIJVTXqEUNHEC
         CpFsCscUvhjogSyPJJWAJDj3xat+XAp38oIhXAcpAwSuotH3LQmpELYqbJoTL/c1CZ12
         8fDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780332311; x=1780937111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuechEhgIbIp9Ei8g9Ubfks3HTEaKTHpGRK7meqRSP8=;
        b=Zosvu4ocCarAk+Grhx2z8xURDwVMSlR2hDHmpFhnz996KId3/JA+lJFZeGhVbLPvQ7
         MR1lOxNTG0hE4+3Qt+MEP+ifpY58Jn1UeWjJDlx7nMz/w4Z/L27ze9EHqJhlKcZVMa+8
         jemFisSZNXZ/T7Z6qm+Js9vjh0oR4jjq0ElHY1Stjuq8OuavaSdopDH41hl3gh1dxZxJ
         5KC7UjqMCbaXdVxXjMqk4VrbAmkGe0DQc801XV9KFFQhtz7AyGOLD8CVNcaUJy57vT6f
         TyUL/vU34x9wMnc8N8vCoro/DqgotZ21thmIctJI761mYZMh12/JwEf0X2VKIjup1dm7
         YQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780332311; x=1780937111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SuechEhgIbIp9Ei8g9Ubfks3HTEaKTHpGRK7meqRSP8=;
        b=iWub/9c1tBat+dq9FrCOXb+5gbIYkdOyjC5LQqUZdHyZJPC/NrWR5DHwXJhcJwvXpX
         rCtJj2tBCTXvPamLybxs15n0mq7m9HVOHEM1jq9gTLA39bNrc500IDyqcGYQRK+9sPlC
         B0Mmd2KKnX1eXwC3s0gMeNS9gxVzRpt4EOxRlnWKdlpg2h0fT8vRpXLYbVreumLKDrIq
         W5e1yf/7t2/GmSPr9eFwXW6+xNKsXKIxHBSe7H38DuiWGYe8CBMISHjU/HXnt0c8M9eq
         CouqMsn+tM4yV9WWllUFbZGbBjGwz1ABGGuhkuajwNvibJCkBbpm9oTlG8J8/Te01QNi
         9oLg==
X-Forwarded-Encrypted: i=1; AFNElJ839n6x98zwC0HIjS6hen0FzZt0Wuq9vwa3JlL459v+/4U633GIE7aGj/Ip8BsE/o5NtlGFhr9i@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuLxXa6aeHDSgUIToJDW31JUAReIAE6L/kstpGNdN8oDQ4AqP
	8DIJL3EavGbnOWaPVjwBVXj2IgEleBafDFWJQWc21TfEs76Oq/rntZd7q/E3yptRaSz/EkOxNR3
	aFAuKSEiq8z9+a68S8uHHC+pYxGLsskg=
X-Gm-Gg: Acq92OGXnUlIMLo2HAlAKwfH3UmlmQsLtHRfOTElvTD9F5MlUsUNrKncwXa9nB5Rh1q
	plNznIuI3jdtF3F/u6q4cjPHHMQIqQiqTqzaHJOSvLmoE82q2TtuuHKk0hUD9J3b0jypw+iMeEF
	DjtZMw772MaBB0ESdOR/PC5al9MRVmiavU+1p91xK2IxwlO9rxIe6BOXQ3Zl+3+xfUIZx35+d61
	KlLsf7o77vww47tTQkrDxHh4L7FSOf/YbFH7xSaqF3LQIeOSC1Qvl86bJ9/sjNRGB/VdmXR8vdk
	QKTSWsdkECEdqqDDoqAdW+Lq9c+/3m5Fg59W1TCfzVCEcdT8Cw==
X-Received: by 2002:a05:6000:1611:b0:45e:8526:7dcb with SMTP id
 ffacd0b85a97d-46018cde5c3mr378861f8f.7.1780332311119; Mon, 01 Jun 2026
 09:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com> <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
In-Reply-To: <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 1 Jun 2026 09:44:58 -0700
X-Gm-Features: AVHnY4LT_5ehEfmIR9cnGphIbcSEKQX4RD4VzS-3orz-D5X1L6ZBlUnrbx8nVYA
Message-ID: <CAKEwX=M5KiWc8ZZTEXCXtxeBrQho3Gs-JnKmBB=YNUkp=WXaKA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16523-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0A3D622CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 4:07=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> wr=
ote:
>
>
>
> On 2026/5/30 09:24, Yosry Ahmed wrote:
> > On Tue, May 26, 2026 at 07:45:58PM +0800, Hao Jia wrote:
> >> From: Hao Jia <jiahao1@lixiang.com>
> >>
> >> The zswap background writeback worker shrink_worker() uses a global
> >> cursor zswap_next_shrink, protected by zswap_shrink_lock, to round-rob=
in
> >> across the online memcgs under root_mem_cgroup.
> >>
> >> Proactive writeback also wants a similar per-memcg cursor that is
> >> scoped to the specified memcg, so that repeated invocations against
> >> the same memcg make forward progress across its descendant memcgs
> >> instead of restarting from the first child memcg each time.
> >
> > Is this a problem in practice?
> >
> > Is the concern the overhead of scanning memcgs repeatedly, or lack of
> > fairness? I wonder if we should just do writeback in batches from all
> > memcgs, similar to how reclaim does it, then evaluate at the end if we
> > need to start over?
> >
>
> Not using a per-cgroup cursor will cause issues for "repeated
> small-budget calls" cases. For example, repeatedly triggering a 2MB
> writeback might result in only writing back pages from the first few
> child memcgs every time. In the worst-case scenario (where the writeback
> amount is less than WB_BATCH), it might only ever write back from the
> first child memcg.
>
> Similar to how memory reclaim uses mem_cgroup_iter() (via struct
> mem_cgroup_reclaim_iter) and the old shrink_worker() used
> zswap_next_shrink, we need a shared cursor here.
>
>
> >>
> >> Naturally, group the cursor and its protecting spinlock into a
> >> zswap_wb_iter struct, and make it a member of struct mem_cgroup to
> >> realize per-memcg cursor management. Accordingly, shrink_worker() now
> >> uses the lock and cursor in root_mem_cgroup->zswap_wb_iter.
> >
> > If we really need to have per-memcg cursors (I am not a big fan), I
> > think we can minimize the overhead by making the cursor updates use
> > atomic cmpxchg instead of having a per-memcg lock.
> >
>
> Because mem_cgroup_iter() always calls css_put(&prev->css), we cannot
> simply update zswap_wb_iter.pos via cmpxchg() after calling it. Doing so
> could lead to a double css_put() issue on prev->css.
>
> Therefore, if we switch to the cmpxchg() approach, we wouldn't be able
> to reuse the existing mem_cgroup_iter() logic. We would have to write a
> new function similar to cgroup_iter(), and its implementation might end
> up looking a bit obscure/complex.
>
> Currently, this lock is only used in shrink_memcg(), proactive
> writeback, and mem_cgroup_css_offline(). Note that shrink_memcg() only
> acquires the lock of the root cgroup, and mem_cgroup_css_offline() is
> unlikely to be a hot path.
>
> So, should we keep the spin_lock or go with the cmpxchg() approach?
> Yosry and Nhat, what are your thoughts on this?

TBH, I think the spinlock is simpler at this point if we need to do
all of this explanation to justify correctness of cmpxchg :)

That said, if memcg folks feel like an extra spinlock per cgroup is a
bit much, we can go with the cmpxchg() approach. Please include a FAT
comment explains the compxchg() approach's nuance in the code though.
Speaking from experience, I will forget why it is correct 2 months
after the patch lands :)

