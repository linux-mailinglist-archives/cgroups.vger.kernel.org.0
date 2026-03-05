Return-Path: <cgroups+bounces-14626-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDcEEV33qGktzwAAu9opvQ
	(envelope-from <cgroups+bounces-14626-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 04:24:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02820A806
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 04:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 073F0301A9C2
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 03:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0076270540;
	Thu,  5 Mar 2026 03:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFAdpfzn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65715140E5F
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681050; cv=pass; b=fP0v8ylES4Afm7ydBB2OHAbvHjZz0GO5GbhMOW9HF/MvkvMK9KT7WQHr78E22H7oZFB5CzJ+5KAqh5G4m1k+b7qsRg2dt/bma//uk0VgoOMwZ6L1bwb+dwZhjynDMxm4WmUHs/WC8tpx/JHp7fL+z0FgXee4szzSiNE/LLM+1Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681050; c=relaxed/simple;
	bh=G5a9YB3C/nkoeFRYthM3M1t8LnTG7Q+64VSx76RGpnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiBpImAUxfBK59PdqNjdtCiwrKwwqlXVQPAYwgaDRWMjyNGKbswRq/x8QkioyCfmzg/1UVc6v0B0R9i0VEnSP70DRa7R8R3m453qUwJA/yR60DAjPdgYtaq0bJLxFtFgaot1iXe8gS2i/GNOaVFd9hIH9isgQN5ec3MbLbtkY3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFAdpfzn; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506984b6d83so59429571cf.3
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 19:24:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772681048; cv=none;
        d=google.com; s=arc-20240605;
        b=DK9ZforeN7W4Hv7/KhmUU4couW2XQYOeTy0XJWS57Jyz0l4PuY6xhL0aepefJlJSsx
         aoDXQSIQ3T/DlRwgxDVVhF2hih3wjiXloXorPK6CUMB37H0BpozNULZlAqgrik9zyapr
         7tTOrzZoetF1ftLQ8muB79DnRV9iP+SRIDwnP5KDWq+GOAh41OFZkyzsMEmcU94u/hcx
         fJibfyBverM/XJGZGuL360+1IG+3ysEDCvf9zd5mQvZr5tTuiBpaDFC3oGj/yszYy55z
         gbgcihR0FyEywf+ywC86F7OFOMCY/tkLw4Rz80gUrUUnKwjFkHOz8Z9TCD+d5QuKb1I5
         HeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G5a9YB3C/nkoeFRYthM3M1t8LnTG7Q+64VSx76RGpnw=;
        fh=TfCxUFVQkJpKB3MbmP21LE/q0fBrOEV2MbQRlhWkhto=;
        b=XhY4vK5L/PmLiKBIdaPfI95A9jG/erhZKyvzKCqm26llfx72u7104LEfky85EJi1dx
         30k+6B6OhVoOy/ba6TEdECRSZLIz75UYBP2+PqMHanYmlr/G9Rp3XPCoX2wK6Y8HPB1j
         jExNLCBgL5fYfyAOg9qrDiMGvxdr2MW/8ZeQ67+P9lZIfbxntyxNolMI2GXPKcI//NA0
         YyLitArBricVUPq7x7WtbxnZSn0i+USTGDXcPdmo7w3dp0WYvSmaM0rCz3p+BJyBXjKB
         NEi0NwV06yOd+fiNZvKfPoQjDPVC8Goh79Djr3AzVg1zAb7gMnXD7CVcLlzyESLgiEef
         FltA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772681048; x=1773285848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G5a9YB3C/nkoeFRYthM3M1t8LnTG7Q+64VSx76RGpnw=;
        b=YFAdpfznI5xGrWhC9rCagi78UYCMlsARufuwIrplE5cNeA4241i4PJh1BRjMqqDDRL
         V/oG0jR5OSzzS8sJqJcaDXBlprtAITefl/DyHTh3dVvE3SI0FoRP/aEemgB2NSJmNUgY
         qbJUbiS4kxXyNP4I+evDjKw+pgQGXxyc+CQkc2e1v/x5zLHHeEBSF0CMM9cFoFiZclZV
         Rf4rrKRaDxLK/9YnDmeJ0QkXAyM+D+WWT6Yd255lVeBJir56p5k/Zs17atT2Q9VFczIt
         tmOcwBo2kOGW9Qmo1tJgke4mVpkRox5mdCx+Dwo7/M4BnbW6T0pV153QAQ74y3MFRdNa
         hLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772681048; x=1773285848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5a9YB3C/nkoeFRYthM3M1t8LnTG7Q+64VSx76RGpnw=;
        b=BsJ3VzYwbJCLqINo+w6DnPoeAqR3qxI04hYn1OTYpM/HLFJi3DslQOQWh6H0izjhl8
         VbTLb+hcsyA/oY+lzsrzhaFXSYD1hUmo8Z+VvPpSkmUYg3yDCsYQxhSRxeVowEgm142s
         z6KRRBrmovFTRT0qlzj0dphmOfzKyJM5GDJ5iL8+n1xQhK7Km6dSwnk3XCkxGV6RAPFI
         J3rhq/6HM499Z7VRxFYrI1edoSVI8is9k5l+C+lqvH7NNMVbGMGnhmoeu4vv0c4d9ImJ
         RcwVYm9RZAehfLyWCMVCXlA4VsAPrb8QwW26iEel4nVIoaoYnKiXEcXPeXCQICys0fbN
         BCLA==
X-Forwarded-Encrypted: i=1; AJvYcCWJgpYbYP5RzzXRcsUwJ0myNkTp42BgqogwpqTrS1Jj/sRbvV66/nQkMKLeBe48u+H2opKXN8nW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8WMFdUmcadFocxM2kk5YljqEXF+9oBjMRENzrJPo6ezcF/n7
	pKt1bCnbsLFtMvcWPjwNnbCL0jjfvzh+4+wip8FQxFqdLIvs5dd5/SZztyRFCtHonyw6IVhvkwF
	y/K80K9W7hBOo4JkpSyc2uH1tWrrbzkE=
X-Gm-Gg: ATEYQzwSozzRWoRt7Iti5GVes0mz9Dfac06zaUZOPZNfU/uNb9fp2K2bta5eNrqrvYc
	XlYSXoIlLzYS/IDCKoJlPxfhV08STXSDUDmPqe3HAh1XazS3C0d/JXy1je2E6DO0Pez7LmC3pPb
	X+tXLpfALcZyMXlP/rulQax5H0dBCjUxMwLorsNu5dc6H7dz/Yk6/r6XsKS5CZNiGw9iKe5ZA6q
	x01HENBw4cZToBDB0yltOLZ2kt9oz9GI754eqVrInolkFZ51IKlC0ZkGqs0XBgnvViPnzpUQbc2
	QKK+fcPC7J2N82wQmRA6zzl5UsRbaEo3La4b2cb0EMJNo2ENzn0tCn4lIvBDLYFXG3M=
X-Received: by 2002:ac8:5a82:0:b0:506:2041:13ae with SMTP id
 d75a77b69052e-508db363745mr51559771cf.43.1772681048271; Wed, 04 Mar 2026
 19:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224020854.791201-1-airlied@gmail.com> <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com> <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
 <4fddf319-50c4-40ab-9e36-04d629a8855e@amd.com> <aaWZrTZGsxxjbBYv@linux.dev>
 <8efef755-e429-4cec-bef4-b15b3f9f4632@amd.com> <aaWuoe_CQwbtcxEY@linux.dev>
 <63dccd9c-f2e5-421e-ac3a-a7c13cec9121@amd.com> <aaXEDLpXLROBO7To@linux.dev> <391bca8e-3685-49d5-8b30-93ab4eb1e84a@amd.com>
In-Reply-To: <391bca8e-3685-49d5-8b30-93ab4eb1e84a@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 5 Mar 2026 13:23:56 +1000
X-Gm-Features: AaiRm52xxbcXT1ZoLRq878o0n1p8F3LnOqlotJTyAdn9potmOsnXs1KB7tA9evo
Message-ID: <CAPM=9tz1iT9pkODPH=Bs=FAFr3To78Spt2QHuNGdoFFJ_6P74w@mail.gmail.com>
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch, tjmercier@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DB02820A806
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14626-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

> >>
> >> What we would need (as a start) to handle all of this with memcg would be to accounted the resources to the process which referenced it and not the one which allocated it.
> >
> > Irrespective of memcg charging decision, one of my request would be to at least
> > have global counters for the GPU memory which this series is adding. That would
> > be very similar to NR_KERNEL_FILE_PAGES where we explicit opt-out of memcg
> > charging but keep the global counter, so the admin can identify the reasons
> > behind high unaccounted memory on the system.
>
> Sounds reasonable to me. I will try to give this set another review round.

I think I will try and land the first 6 patches in this series soon,
this adds the basic counters, and ports the pool to use list_lru, so
drops a bunch of TTM specific code in favour of core kernel code,

They also don't create any uapi, it's just two counters to expose in
the VM stats that the GPU is using that memory.

Dave.

