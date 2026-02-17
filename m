Return-Path: <cgroups+bounces-13977-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBrGE7PAlGkXHgIAu9opvQ
	(envelope-from <cgroups+bounces-13977-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 20:25:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5A914F9C8
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 20:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE8E8301FF86
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5C737418F;
	Tue, 17 Feb 2026 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q59LI2Zx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC299354AF2
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356327; cv=pass; b=PwSnsmafoV5utqYPxlG1epUZalIGTTVd8n/2opzJ4hmm2u3OSKCdv9s9hgQ5opClu0Mj/f57rbAN2g5EWMGv0WntSbPrX/V1rhri6YMuEA/tGbGaI8bInJ7HZEMdGQYl020dgh96afK/qHk9hn/D20eJzN/5AZccEh2K6gAO1vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356327; c=relaxed/simple;
	bh=sewE/sl1jGzvTdHwbA17sP0tHhoksdxDyaxVGzvfzrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFcYHin7oWmGgJvC8t3wYy5K5zloj+P602krcL1okTduZY257NdW2eQC/TyW1VYspwFtG/zGLvKdKTUUxJJ9y90nrxak3s/kCpXasl6YEf26IQvLVuZJ/DhRvNFaf2iGpQOst+PQuNr4gEmKoXNKVV0Ujl77HtggbgMxCceviUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q59LI2Zx; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so7785e9.0
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 11:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771356324; cv=none;
        d=google.com; s=arc-20240605;
        b=B0LjMwRplNOyI72svpFB/LxtDtKYE/xf1ecvO+l7j19INBSYmP+1tCZJV+9ztguFza
         21MLdvPyO/1s8ouWZufatrUpvHxrigfk/tkRqeuHEqZLpDY/jsyyyIvUQP3f0BCM5s0U
         KvBwjVIwiORrQiYj8TODliwXFiP112cetheBj54ABplzcYC8YVQ4y6hG1ORzmZTrNAWc
         0ZOBbUkIpoxhO19HLWyCWyTbPemnhYEsCL/5tj3dqieYJlNH9X/Ta/YFIQ+QDc3J2iOg
         cU0mccEb5sd0Z0t/FbmW/jr4jw1guwi4fwaAbDGuQ7zQLft1HBn0hKlCsh8jvFa5mS7h
         M6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g0ibeNCc7R8HXhy/DdkWxEPCCxKLgy5A2bxR1yxzMM4=;
        fh=v9ADQaK8YpPKpjKovZ4blGjWXt5AmiGrQO0sm9801GE=;
        b=JwZ0V4UjrMREWLsWCor43iAQvU/qHpUzEJna/fjL+lw3z7TUk2R2+ORx/uyjHj352x
         jVDwc7c1lOp3PyQttHYQUpQdAFyqJKcLILAsewFcwl/vrPD9Kn3r5novb4DlSVzNF9Kv
         I1Mcz2koe6cZHetC0Qnjr1tRNO/mEK+qJZQ5T5qpLQ8tKQ3s7t27/QWhGFr1z8YezeTA
         TPaZEnvF5zkfokPU/24W0hPWpAYYiSfQum9Y7ZcdR5dAcqRhNFcsbOuWMq5QwPpyJ8gn
         QBVpntUJRRa7nVAyZJ1izCXKXQh7mmn0WUaGBSeOxCS9yDhAtSquU8LE60igrlpQdSco
         Lygg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771356324; x=1771961124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0ibeNCc7R8HXhy/DdkWxEPCCxKLgy5A2bxR1yxzMM4=;
        b=Q59LI2Zx9PcAYnnZjqw+/AHHQ1HZChY2vm8f2vJc9Vid22Svfgl3trmEjuZUtWCViG
         EcjCxZi+TWL2HSyDcqYRG/x9s3IM6FWH6lNz/X3Rk2RUvdMzMPvQ0au3zA6PT9FKGvPe
         N7qRSrU/Qn7x38gmZFsl2npPmg/cmZLW24ldmBLBIa5+DLKeA+VCH/AHhdS8HuKScwGw
         5u+2hJHo3XwEkCdAGnxCRwiIDjF+RnT8AaE4WglFf7VzEO+iJZ6efsD11paeNHKi10pX
         P2KuyXJAbXD7kpGCPZ05qo+dgNHEYj8aFlL+jX+aoxfJ/KyBZr2ZQSRUiAhVnnY74uB5
         pBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356324; x=1771961124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g0ibeNCc7R8HXhy/DdkWxEPCCxKLgy5A2bxR1yxzMM4=;
        b=sk5WxWibDrsr3SHbX53Rhg+9ulgF5Y20gbyTYGYKH+ZU3rfuY4yEB1b0ZZr+rQG7oC
         fe3UfWCt1v6x13qV2X432zdg+yAd86xvgn1OxmwMVAeb9czpq9MJ13aywrQajHPtvo81
         Cfqk0anntBdS8PyAR/63RY8zs+d6CEC0UogVFPKsXX5SXhTrIvrPtlDBbaNInhgGrXp2
         2UROwLJxqTwd9bjNuPh+UwckLrXfEnwlD+sKT+1S4yIho6Yf75vpAxzLbivW9qUr7rID
         9yc8V+IU23OfYiS9uPhXJFuEEjg8p/aX+ejVKKwn27xdz455sKmYfYyf8eNgmY5/TVre
         WL8w==
X-Forwarded-Encrypted: i=1; AJvYcCV7+2bXc1PFzu1SfqyUDbrDHzSy2sSqhh0DiU6AElHIX9p4UFZP65HscDZSPQ+NkPcuQLtbk0wt@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPGgjk8Bppo3mxk8i0aqYaPkTnkRMhcTw9PjcrlrgCd6dv8C/
	6Xu0eXQ/RWK53lPjF0bQGAuzvR0g2tMmJEGhy9EmdbzpW6SoVjpzSC9WWDmwA8k3vnaH44nlHv8
	IZRabLBsBhX0HiONllSH2GzQSdyvXEynR0tPumx9Y
X-Gm-Gg: AZuq6aKNehzYSBaKx0h14VGmwJhZrAs/cbJxX2H3gk2baGe3zRPj/9OIf1NaRTWmxMj
	pILPifYK+uAbFE07pAr3Efl9x/Rs3aY0IBuoINTj/8jjjn4TX/ksFFI1PRhlBmINFcdtvGjrH/s
	TBnWvghQkGw84U+5/kCAkF/pxPH3/Q+N0qVF3tKZ2sxfw5wXUNG/aqfuA8d2UfkMwCoZW7DjSJQ
	9Lb6omu4yBlJA8bkfaxz40S3RqZKKE810/T4zXauIDSb0Sk4OPhkxYGefK2I1r8ifDlduGsg2y4
	8UzC5de/ooQxQ1JRozobPQNssslLENG/FYHM3wuBYCnKD7pyPzOVsvCEsEYpyjgUi0LvvQ==
X-Received: by 2002:a05:600c:63da:b0:480:4a7b:228 with SMTP id
 5b1f17b1804b1-483885e39f1mr1287205e9.1.1771356323780; Tue, 17 Feb 2026
 11:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <aZNDSl3GPrNBGwmL@amir-ThinkPad-T480>
In-Reply-To: <aZNDSl3GPrNBGwmL@amir-ThinkPad-T480>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 11:25:11 -0800
X-Gm-Features: AaiRm53P6sMj72saz2iRJgcKdNr5FDsRWfFewzT5upX4tAB-ZB6-gxFZCLtvsrU
Message-ID: <CABdmKX0CU+bOVDdq0V50TfP6RHr23EJj5XeA_e66BC45gLDsFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED
 support for files
To: Amir Goldstein <amir73il@gmail.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-13977-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[memory.events:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE5A914F9C8
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 8:21=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Feb 12, 2026 at 01:58:11PM -0800, T.J. Mercier wrote:
> > This series adds support for IN_DELETE_SELF and IN_IGNORED inotify
> > events to kernfs files.
> >
> > Currently, kernfs (used by cgroup and others) supports IN_MODIFY events
> > but fails to notify watchers when the file is removed (e.g. during
> > cgroup destruction). This forces userspace monitors to maintain resourc=
e
> > intensive side-channels like pidfds, procfs polling, or redundant
> > directory watches to detect when a cgroup dies and a watched file is
> > removed.
> >
> > By generating IN_DELETE_SELF events on destruction, we allow watchers t=
o
> > rely on a single watch descriptor for the entire lifecycle of the
> > monitored file, reducing resource usage (file descriptors, CPU cycles)
> > and complexity in userspace.
> >
> > The series is structured as follows:
> > Patch 1 refactors kernfs_elem_attr to support arbitrary event types.
> > Patch 2 implements the logic to generate DELETE_SELF and IGNORED events
> >         on file removal.
> > Patch 3 adds selftests to verify the new behavior.
> >
> > ---
> > Changes in v2:
> > Remove unused variables from new selftests per kernel test robot
> > Fix kernfs_type argument per Tejun
> > Inline checks for FS_MODIFY, FS_DELETE in kernfs_notify_workfn per Teju=
n
> >
> > T.J. Mercier (3):
> >   kernfs: allow passing fsnotify event types
> >   kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
> >   selftests: memcg: Add tests IN_DELETE_SELF and IN_IGNORED on
> >     memory.events
> >
> >  fs/kernfs/dir.c                               |  21 +++
> >  fs/kernfs/file.c                              |  20 ++-
> >  fs/kernfs/kernfs-internal.h                   |   3 +
> >  include/linux/kernfs.h                        |   1 +
> >  .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
> >  5 files changed, 161 insertions(+), 6 deletions(-)
> >
> >
> > base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
> > --
> > 2.53.0.273.g2a3d683680-goog
> >
>
> In future posts, please CC inotify patches to fsdevel and inotify maintai=
ners.

Got it, will do.

