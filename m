Return-Path: <cgroups+bounces-16525-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H84NMK8HWo/dQkAu9opvQ
	(envelope-from <cgroups+bounces-16525-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 19:09:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445E6230D7
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 751FA3016D14
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567683DCD8B;
	Mon,  1 Jun 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7UGfAhq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517C3803C7
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333715; cv=pass; b=fMV5SI8YcZo2maF52tGXDoHvpTZ2sWazvKL+/EVBLBUZyJwDcLI5mZUcJl1B/basrcmrrl19+qImI5qadnpV4nnT+NWK4VIfiqiuY/+y0i6FRP7L23xs2wy1hGpYlMRPcGOidoVuXAQLO1RvStQquEQJO//8XzdHgZC1Gtv90So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333715; c=relaxed/simple;
	bh=Fwo9lRnl+caU8n+bkKsCokOR7tEa4er/MbruZS778hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBtQh4Ks5/LsG/dldClKXobofHiQw3a+kY6y2ji+L2plboeL2Sn80wZ+1gN7OYxrmINHBw2AyvteD36TD8fJHHda5FAXbVdppfDcli/G1mVsw6r1eRueHWoP+T+6XXYIZ87QbH+rsK1hHtXqz6kLdddxDCEQdZUkBGb160FkSK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7UGfAhq; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-460166910e6so411706f8f.2
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 10:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780333712; cv=none;
        d=google.com; s=arc-20240605;
        b=XVFvDn1oH+N3sXLp3ivBnz27bmrbE9fTpbYtwm2eurZyx4aUjtpUO7xLfwnurEVSG3
         Hh8ljC3N2ruGke4Jkqek+fKxe/DpE7kwUHxCtdvGjTf+sbVn5uWXBDIB2EfaJH86NU1P
         MvtHqWwHhQ2U7+li8b3lk5/xiUcCxCbVbyH2XL7+QfXuGqSLSRHHQG6wcjR6RDu5a7yc
         ujta8ikCYDMOT4CwFcCeOzB13HcZE+7FRRCgnCYZnofZq0HA0/ga39nLjtLoIGC+mlZa
         Um7tyuNunIqQBrgW4quHnJQ+obQgUX6CGfUHS9vnvAa0cV33rDNz4WV2/HrDddnI137d
         M8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fwo9lRnl+caU8n+bkKsCokOR7tEa4er/MbruZS778hU=;
        fh=2yGxiumZ+wFBLjK84bZoivLmZeRPNiwrlZwQksPcKSY=;
        b=Z77O5YwO0K1Jy5yqbK6I7dVCu8xya4g8ervDzAlEIDU3p/dUtrop9+NG2zgNWudGal
         sSvFaRVK2Gq3WsH5iZw/FlG5PSdQVl8OvkmGsDIT7SHKFmk3Zmr/f0WVEdYZU/i0bSDq
         KxSvsRJacuBSjnDXhD8K/XBZnQWwVvzSWkDaeQc7mE4TX5uoVuhCHGvsdrjU5W13oxaY
         1iJqW5Gk0Qb3eTBEkCpUFLXHSHBxQEsfk+iEDzgTH/PRsoyo2avYwSCy6wgzAMzs9YNY
         dqW2tFFkcMdXnUVPN1ID/pwmmO9hHohuo3Htcz8GLNcptDQt0vB60OtUs/O/Imyg8JOH
         7XIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780333712; x=1780938512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwo9lRnl+caU8n+bkKsCokOR7tEa4er/MbruZS778hU=;
        b=k7UGfAhq0iqhq/RKGRfi4ukFlPfV7EWWiODDDeRBrWdGgYbqPyhvBy5Hwj/IfjTTDx
         l4CTISTX1QHCrCUt0PuH31LrvstZwlAl9/skCPSEIFPaYoOZpY6YBBQ0BSSG4eZy+kSe
         HIDXCMxyfRFTPXgNPr8+WKg7SzHBkyO15LF1fytdCLlvIhdRbw/R8RPX58ekl3MkNakO
         0Gsu6meStTt5LSJcm6d13oGHAfTGiU4pELQ6FUgbltf2QXPoeaZiDNqP4fSdSA71hfTB
         IQ6NeedL/Ghv9yDYP7P96nUOhkALAhvbCC22PWR7wAFQ8zHOsJmu/NVOq8bfcIqiABqy
         DNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333712; x=1780938512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fwo9lRnl+caU8n+bkKsCokOR7tEa4er/MbruZS778hU=;
        b=KSWF6EE2Et3TKeZFq2+qFOKvRtId7qmwQMVJIDzBigmXewiXhgsYXf2NFnmAhWEorc
         J9EHOBwX8NdfLIf/619iJUQFYeJJrNNVPWfPkQC2MZ3zcGER6NokkyQteKWwrRZcMwoo
         rTO44o82VfrzE8se3YGqNAeQBjxS60/vXmBs0z/S5l7Tf9cFnjuKHNNLZkEBVZbxd1VS
         Dc4LotoUpzWd/b3sQFhu5d5XKkPh1aOGB0JSXz9cFs/bsl6bJ6bac7G4HF0tipuIIAxN
         m1q5oDx5uoM/mkpy0/LNaRlfzKxjG6OnIn6xp/x13as48mkeRo4XZdd3QRnR8nd1w7Vu
         6KAw==
X-Forwarded-Encrypted: i=1; AFNElJ/GUkD40YhKga4jm+EEmj2ETmzctZPQyKYkBb//TzOmigylC0xrxacQCKDdpjQtp+nJuSoxHHkS@vger.kernel.org
X-Gm-Message-State: AOJu0YxCaBv+7ozaNvgvJYzSzbDp886W4KrfaouYUoTh1q82s/LVpqhq
	+lRau9hooPzGdJMRuZqfrny8Boi293PJBLKmDqRVvRXddwRaWjJO4dCEO4rH6enXrGG/VT4CbKx
	8SmctWcZBQ5whTjc3wHHtM3tLMt649/0=
X-Gm-Gg: Acq92OFfHsIs3sd84W+kf5fAKevMXMt/K7CcQSUqcQVL+vITGNGOMb4de4iqPECLGZD
	O9vofaE2eyfjUxjrUV9nT/zSKZNMJvFREPuagkMrpjOMOwonp4sTiM4maiIC/YwXypWnIC1dXb3
	FYEt7CuGjHnyQpPu/3ljTLR4Km+As5QjrGDv8L3Kjf09dIjUhguTtUavXD91LDjOL1EMduIsLsT
	opgHWoF0Us8nFOIfbeWBt7ZZa2A2yZWj+Z8tvJMQeCUyhbw1i2CMbODarmFuqdGDgCQtRIVo4Fo
	zK+PUQ+lEBVqYiLh/ncHqheglBqwwdfmNBTQxVF006LAzgduIw==
X-Received: by 2002:a05:6000:18c6:b0:460:1301:ded1 with SMTP id
 ffacd0b85a97d-460131122d6mr4841379f8f.6.1780333712087; Mon, 01 Jun 2026
 10:08:32 -0700 (PDT)
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
Date: Mon, 1 Jun 2026 10:08:20 -0700
X-Gm-Features: AVHnY4IPBYIavrsVjRZcklh2r0yiWvzcpUqLWkliFzeatE9D_yJwDY6lgq1MVZs
Message-ID: <CAKEwX=NoQNXOMDD0uTSOPWHQX-CMNU1dw=zEuFj=eLcS3fB-ow@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16525-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5445E6230D7
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

I think each proactive reclaim invocation just walk the entire subtree
for page reclaim right (see shrink_node_memcgs())? Would that be
acceptable for you?

I also wonder if we can at least make this structure dynamically
allocated... In a system, you only really invoke proactive reclaim
against a few target cgroups, no?

