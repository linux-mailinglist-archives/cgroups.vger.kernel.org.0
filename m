Return-Path: <cgroups+bounces-7422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8EA7FFFE
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 13:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557FF3B1E11
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58C268C66;
	Tue,  8 Apr 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JW1B0Flz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58B268C79
	for <cgroups@vger.kernel.org>; Tue,  8 Apr 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111215; cv=none; b=iZ3Gfql2sygGvnsJqfvEqgTb7/mvoqX8MrvrueHHXZVvwlbEkM9GHdiYCNDtu0Uk5CHh4Z3TyhTbOvTaxghoog4x1R6TLUtzzd6ObxexpwhszHEdy987M0xQQgUjoP+g9BiSphtZFJtzp9AJd9E0P566SxNriXZpP8PFQlzs0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111215; c=relaxed/simple;
	bh=IsnK/CJhMOB5ezHxsAL2yUfPY5VpgkdOg9K3FGVRifE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvVlf/ozABWK3DXzh8SQKLnEppfxdPRPdbNZMu4TyKWZ9X80hOorwu/OWzF7LKi+5vI/iBi+ujhGQirwbW7YTzCIOfW3Ii7Wo31+RR6CRmeXVJwaFBW2zi22rCMi9KRWHrBNr7to51i6/HpOs/oRWIe/hEG0m2zJwykvWOP/H1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JW1B0Flz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744111212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxlGUJtYElxMWl8rsjV0NknW3/JmIWt6QA0dt0dS8Gg=;
	b=JW1B0Flz1OSNpy2Le5EkHFwUS9EKwR4LGUPFS9n092VG3/QYVUMo5txyTkYwLI/h+C8p80
	yt48+ic/dgyBXelwB/+qSaabb80oJXUeJkEQPkvY9RMaDGhrFk6QND08fpPzQd6d+D1Ktc
	cT/1OYdMTmpLb3PIXh+Xl0w/FwwMXDQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-eqwFPXL8N2yhYBOQo6mPfg-1; Tue, 08 Apr 2025 07:20:11 -0400
X-MC-Unique: eqwFPXL8N2yhYBOQo6mPfg-1
X-Mimecast-MFC-AGG-ID: eqwFPXL8N2yhYBOQo6mPfg_1744111210
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af972dd0cd6so3536639a12.1
        for <cgroups@vger.kernel.org>; Tue, 08 Apr 2025 04:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744111210; x=1744716010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxlGUJtYElxMWl8rsjV0NknW3/JmIWt6QA0dt0dS8Gg=;
        b=cym+vgaY6Q4bxsPMEeKV3E+AkHxHnzRXAMhHBZ60TR22sWUXL/xo1QdG7Qnj40cUlh
         VVUQGJcuhk6z1qhPTJNW+MSc4t0HQe/WZhIVGFRlwcEIYgFYPl+onkfIVjg8iZBT0umx
         7Kg/YjzgKa1oWtb3gaq40/rHS44aNhMTKUXsyzisBfnXbr2smnhAu7s8tqhjCyQh3Sew
         4WAK5hPtuAdG7ZiDPqPJ2o/Ey1EODoCOoibXAyJZTWFzOpLWrX0yNYHUU9mtLwljN47c
         PfbNIi4+jNGtBv04a6+my0td8S1f9mCZnIMuPaX671XjEZAMoDLPDaFp6Qk+iozkl6xd
         fmEg==
X-Gm-Message-State: AOJu0Yxc+hFIJvKkTNovJS/5ZRDpXE1B48JifBzHPc7j/IY2v3oewUyq
	Owczy4XUHBc7aJRRxSz3AFTjQugOH0vI+KWf+EKMWoAug3KyOAhD0xmGrN/HtseFMJaEVIZE+em
	x+4HyDXaFWwTIfXohRUgn+6h5tiNEuugQ4JDys7Hq7EGkk22pPsV+AyiYiOh+1ih12Kdrss3zFq
	44GnoIQDA5lM/i0JUs7ueVjbo6e+rp5Q==
X-Gm-Gg: ASbGncsgpnLiIer2xr9O4huL3CjgokZ1+sSxoIANEbInNzJuj5O0LqIHlyO1pKfxXMQ
	IjvUOnjjLotzL2OHvzG9yJ0Ykt3Pz+5wAgNClLpeOtC69nVPxQ1cmU+grhiIFsvhdtxnDbyI=
X-Received: by 2002:a17:902:e809:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22a8a8cec34mr238988785ad.40.1744111210542;
        Tue, 08 Apr 2025 04:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfj3NzNQEOef+4bFL5S7xAlawV84jImrAOEcndKQ7zZiAPCt7WHwsWtCqW95u4ZSL3aeAqCFB/AGt6ESaJB0M=
X-Received: by 2002:a17:902:e809:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-22a8a8cec34mr238988485ad.40.1744111210268; Tue, 08 Apr 2025
 04:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407182104.716631-1-agruenba@redhat.com> <20250407182104.716631-2-agruenba@redhat.com>
 <77b1b228-3799-43e3-ab30-5aec1d633816@I-love.SAKURA.ne.jp>
In-Reply-To: <77b1b228-3799-43e3-ab30-5aec1d633816@I-love.SAKURA.ne.jp>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 8 Apr 2025 13:19:58 +0200
X-Gm-Features: ATxdqUF091z-QTWG4loZUeytMgFUpudH-__g8f1MG4U6oA2wpIwWgfAYKS_mKk4
Message-ID: <CAHc6FU5HrGWYpOwd6OMhG7EdyjB3zp-RV5dP=W-=29VnYa96-w@mail.gmail.com>
Subject: Re: [RFC 1/2] gfs2: replace sd_aspace with sd_inode
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:04=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/04/08 3:21, Andreas Gruenbacher wrote:
> > @@ -1156,6 +1146,18 @@ static int gfs2_fill_super(struct super_block *s=
b, struct fs_context *fc)
> >       sb->s_flags |=3D SB_NOSEC;
> >       sb->s_magic =3D GFS2_MAGIC;
> >       sb->s_op =3D &gfs2_super_ops;
> > +
> > +     /* Set up an address space for metadata writes */
> > +     sdp->sd_inode =3D new_inode(sb);
> > +     if (!sdp->sd_inode)
> > +             goto fail_free;
> > +     sdp->sd_inode->i_ino =3D GFS2_BAD_INO;
> > +     sdp->sd_inode->i_size =3D OFFSET_MAX;
> > +
> > +     mapping =3D gfs2_aspace(sdp);
> > +     mapping->a_ops =3D &gfs2_rgrp_aops;
> > +     mapping_set_gfp_mask(mapping, GFP_NOFS);
> > +
> >       sb->s_d_op =3D &gfs2_dops;
> >       sb->s_export_op =3D &gfs2_export_ops;
> >       sb->s_qcop =3D &gfs2_quotactl_ops;
>
> This will be an inode leak when hitting e.g.
>
>         error =3D init_names(sdp, silent);
>         if (error)
>                 goto fail_free;
>
> path, for what free_sbd() in
>
> fail_free:
>         free_sbd(sdp);
>         sb->s_fs_info =3D NULL;
>         return error;
>
> path does is nothing but free_percpu() and kfree().

Indeed, an iput() is indeed needed in that case.

Thanks,
Andreas


