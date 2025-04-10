Return-Path: <cgroups+bounces-7458-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076FBA84BA0
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 19:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898FF8A7466
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722732853F8;
	Thu, 10 Apr 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Igoq8XiO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ADD2046AF
	for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307312; cv=none; b=G4VWGiTnnsJdvCv5u/G26whr2sMR+xNufSF4Sl9WC7HAttSRUOk4zr3T+ZTE5KBa5IBmOOGqGlT5Q1cNCO61l/9j41MfH5tAD7G1jeiQ6NyGsN20F4i9LN89tH2jGa4HRWHP7andCVS5aghx1bnxlXwdic1jx10fUO6cr7s9ZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307312; c=relaxed/simple;
	bh=9kFVBt0xmNJ1O3N7xNDOXpsY2sp5HC0wOX9IKhNyfoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4aviw//RqT387wFk8LZDpd4dyFPK/nlrd5svo1SVNtnU2fOVYL/+qhnKdF5VEkU24ZF3kJzsG0mWUMMo669PPNJpJh4dS4upULzP4U5DxZ6Q76G11nqjh9lB37TjTt1LcXjxyyf7jtP4j4Z8+yy/shJZ6+rP9nMnCO8VTvQXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Igoq8XiO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744307309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqvPNxA7jww3BXXOwYN/gaN85wuxZPgfj7tUlo1Pygo=;
	b=Igoq8XiOR2jq/FzPAumA9aWR2qErCcMAyz6s3JlB9EEI4xDcCXXp9FEdmEi/q0ByLxeCJ9
	ugiRj3jejH0O45K8chmG0RU1PgDuCS6jq0OUWLSShyW2GQVerQADXPh9B7ZVd094OxVD4N
	mMvEApChBM5BEhJlUHv+cNdLWwbPjvk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-NkvZHwH8MDO8MG0voLvmUg-1; Thu, 10 Apr 2025 13:48:27 -0400
X-MC-Unique: NkvZHwH8MDO8MG0voLvmUg-1
X-Mimecast-MFC-AGG-ID: NkvZHwH8MDO8MG0voLvmUg_1744307307
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2241ae15dcbso13148155ad.0
        for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 10:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744307307; x=1744912107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqvPNxA7jww3BXXOwYN/gaN85wuxZPgfj7tUlo1Pygo=;
        b=YcopcJXKloWOaBk8A0Jb+EY+dwyN81JadVv0VESjLFYNIReqkqeRbjNolxvDG6svq5
         xnBlNL64qzDUV3SZZKmIj5u/9t7ZP0XUVkJ+lmshDcF36/nO4GrO37AzHBw+kBkUwfk/
         1TjCi5kWWCKO/vMKolcQwQMK6nvr+jefOVd5UuEAswugjhQba42U7yXBH4gSnmvhssky
         tK/THEH9C8n/MQdBF+AqD3UjJm7U1PSqmhVRpqcx7cgf31CgIejg7gTGgEMrmLP0LT8x
         zM6q3Cfnjev4KwYP6ZfLTzBKl0WQYz10tMVGmZ6HWAtIVW5cITq5MPfYiO0hId9L59ta
         ik4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVy1JoK0vNnH0BIsJZlZjmIAU4Bt0AUhSD1V3HwziuH1AASrWZkNbPOEpCGhUr54vV0+y+LtxNf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+64tbPG5XS8uDisjzRTlqzd+ekHiN/Fv3Hcw/f0zzByAzQ80Q
	/DmSiWMcjyUbRLDRExrutIvZex3qKC0Ohw0BKX8ufhMGoVLkkivaKVcdxd8daE8aGrQDtaGieFt
	ELHWJioAO51gUcSBfpmeJsviO0/ofUoI3FUJcOlKQrTC9DEm23fpHoahTBaq2SPZCD7EBOAy9AZ
	3yENkoG3Pf7GRYiqxe99gv7ZWfeboQFw==
X-Gm-Gg: ASbGncsKIIHyFWoDxFgkuSfwHsrVKndBDD+1sN88LP5zAFhSOX6ulo544G8yph7h3uA
	RuHzZmpgNDUu71pjvYKv4BdDfo4yYAQWoRZ2TvQfXodVyfG0K3SdfMktI02oNc6F3uGA=
X-Received: by 2002:a17:902:dac9:b0:224:1579:5e91 with SMTP id d9443c01a7336-22b42c5ac2amr51880065ad.47.1744307306736;
        Thu, 10 Apr 2025 10:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUo1DbI1h9w9OLlDnjq5RZSX9CGytc55kczInpUMCnGZepk9T1FYX3YU4pw1A+DuQV82ASCx1d3eK2A6PEVwk=
X-Received: by 2002:a17:902:dac9:b0:224:1579:5e91 with SMTP id
 d9443c01a7336-22b42c5ac2amr51879845ad.47.1744307306483; Thu, 10 Apr 2025
 10:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407182104.716631-1-agruenba@redhat.com> <20250407182104.716631-3-agruenba@redhat.com>
 <Z_eGvBHssVtGKpty@infradead.org>
In-Reply-To: <Z_eGvBHssVtGKpty@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 10 Apr 2025 19:48:14 +0200
X-Gm-Features: ATxdqUF2qSG62wdzI_CXx71qpQw7c7dGZziC1q7bbQkSEqifIFryfqrjJnWzITo
Message-ID: <CAHc6FU6NHxG-Tn+5tn2zy3QJFVruOM6tG7DsDi1sF+vDw4Xr_g@mail.gmail.com>
Subject: Re: [RFC 2/2] writeback: Fix false warning in inode_to_wb()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, 
	gfs2@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:52=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Mon, Apr 07, 2025 at 08:21:02PM +0200, Andreas Gruenbacher wrote:
> > -static inline struct bdi_writeback *inode_to_wb(const struct inode *in=
ode)
> > +static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
> >  {
> >  #ifdef CONFIG_LOCKDEP
> >       WARN_ON_ONCE(debug_locks &&
> > +                  inode_cgwb_enabled(inode) &&
> >                    (!lockdep_is_held(&inode->i_lock) &&
> >                     !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock=
) &&
> >                     !lockdep_is_held(&inode->i_wb->list_lock)));
> > --
>
> This means that even on cgroup aware file systems we now only get
> the locking validation if cgroups are actually enabled for the file
> system instance and thus hugely reducing coverage, which is rather
> unfortunate.

Right. Is checking for (inode->i_sb->s_iflags & SB_I_CGROUPWB) instead okay=
?

Thanks,
Andreas


