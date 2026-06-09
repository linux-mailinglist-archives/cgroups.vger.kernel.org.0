Return-Path: <cgroups+bounces-16759-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HvqJFdDGJ2rK1wIAu9opvQ
	(envelope-from <cgroups+bounces-16759-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 09:54:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5A65D675
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 09:54:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lh3KQeKK;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16759-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16759-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DED0A305A5FF
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796E3E5A05;
	Tue,  9 Jun 2026 07:48:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2F30E853
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 07:48:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991311; cv=none; b=uesidsR5GSCyu7SL+muYt6Ww5UTB+CsTVY5aKUOfNcwE+/r9tICVVDrP07SOOlKBLscStURiJB5fx83tzEpj2FjpoPreNIeIEP0taOsjRRCjzJZ2emQ0xs1GngzdbpocAkWpfl99AV80teY1q383AM6WmNsjEzIi6UsvYTVs6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991311; c=relaxed/simple;
	bh=P3+mzxVILVCJrFtycDB+LRStStiIqPuiAbLfUSeAzUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHk9JBt6Fra1nAjRVPKeAd3xX/HcRV4wie2VLp3Ge0qGULsC//qIGP3ngwekl5576yACquglURdFTa7nmKLAJanFOrQFE6ZTCtximfPU9cTcIaEj8acJFQt+ZAs+cmgh3YshljR3PFSi4LTSZl3KVyXNi3FRBqndhHaHmMhpKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh3KQeKK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3631E1F0089E
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 07:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780991310;
	bh=P3+mzxVILVCJrFtycDB+LRStStiIqPuiAbLfUSeAzUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Lh3KQeKKmievG3xTheEKaVvOT1dmL4oXP4rsslq+cR5khxSjroDT8s+CQnjNG70jb
	 uuMDUyMS6mUFlPLvvToDEw4DAwXpRfZDgJG5eCtvj7gtsFDnHFXxKMKqF0/QuoqZKZ
	 ARi2861UtMbt03vvuhOwDfN4D1SnTBWj7Ssg3Tu4I5kugJJOksutbVhg0d1vz64LHL
	 /C4p5MKkNrFNd74QDOqAvCc+oY60p9/uj5QE0KFcTfH4O5S3LtzGtbiWyH5D9Dsi3i
	 cvQ4AzzEA1tadAKd0Cwj2c/ZgeQcHLzRO+QMcmDNpBk5LKJoUGFSHGRjnBZq6d2dgf
	 X/fAfNoieHZ9w==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9158c621ebbso626425185a.2
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 00:48:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+5eMkeyl7RPpWeKv2x2k1DVHtpvZWAb7UyzAb+G/4ihpu04+Ct7eMMZcxrkNPvDj6jmwlyUZrU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Vsj/X/iGRHXoUw4ochJegtuYLn+EsEcVT/GaFdnBKByzSfuH
	Lm3R29K5RRW4JaTbg9KCIrz8NJp2rFEZ4WdsAsQp/2abPh0eIBd8+S/VgPgVRLHB6zBudXSCuTM
	QDyWCeMX/dxxmSfzIYQFR45WXbkaRVI8=
X-Received: by 2002:a05:620a:c4b:b0:915:c271:f91c with SMTP id
 af79cd13be357-915c271fca1mr1851463685a.5.1780991309343; Tue, 09 Jun 2026
 00:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609002919.3967782-1-gourry@gourry.net>
In-Reply-To: <20260609002919.3967782-1-gourry@gourry.net>
From: Barry Song <baohua@kernel.org>
Date: Tue, 9 Jun 2026 15:48:16 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z-Cd9aNirdvRSKCz07qNqH4EEeF37rGUpGOJnSgSL-Kg@mail.gmail.com>
X-Gm-Features: AVVi8Cfqzi3SIKls0BC4hWZyF4MXPP-oDhMfanMs2lMZ83TPVeLkEv4_siixdsY
Message-ID: <CAGsJ_4z-Cd9aNirdvRSKCz07qNqH4EEeF37rGUpGOJnSgSL-Kg@mail.gmail.com>
Subject: Re: [PATCH] mm: constify oom_control, scan_control, and alloc_context nodemask
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, chenridong@huaweicloud.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, rientjes@google.com, chrisl@kernel.org, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, 
	youngjun.park@lge.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	jackmanb@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16759-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,meta.com,redhat.com,huaweicloud.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:kernel-team@meta.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:rientjes@google.com,m:chrisl@kernel.org,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:ziy@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59F5A65D675

On Tue, Jun 9, 2026 at 8:29=E2=80=AFAM Gregory Price <gourry@gourry.net> wr=
ote:
>
> The nodemasks in these structures may come from a variety of sources,
> including tasks and cpusets - and should never be modified by any code
> when being passed around inside another context.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>

