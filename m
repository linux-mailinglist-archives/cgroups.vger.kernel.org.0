Return-Path: <cgroups+bounces-4049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED0D943791
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 23:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FF2281853
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8316C68F;
	Wed, 31 Jul 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="o/Tz0jue"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95A16A949
	for <cgroups@vger.kernel.org>; Wed, 31 Jul 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460317; cv=none; b=EYpSDj6xPyiHVEZhoGeptKyIejyU8qPFkP6EwUAsoGlWmpeY2Sg4J5Lq0giZ76y9KdgFXdc6U/OBXKM59I6eKMgW6Zzw0hxz+fvDPwxUt1yELQbiYNjjXfEXndhldB1UL5n3aY8JetpXR50nJXtKlNNIeUFxG4Waw6O28+uzMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460317; c=relaxed/simple;
	bh=EZqrkOuzvZ52XOMTxZgs+Cr/oGYo9OlHNt4FT39kZOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcpWySkY/BXFyinb1nERHd5D8ZeUBSdsjWEq3pRVi51Mu3+Uy6Qq5c2iZzyyvdDhSGRe5/sZxMT9T8aeJ7xti5CIHlCSd+IIi9C7QSW3r0ANfKhBD5cNDm81hbPQSbNOsqekDOq5HMALGbB9q/OGgxMUb28xFnIz4rrWLSSVlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=o/Tz0jue; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7094641d4e6so2071624a34.3
        for <cgroups@vger.kernel.org>; Wed, 31 Jul 2024 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722460315; x=1723065115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZvLSXSFJMkLNlj/PaF0YPjUuieX1ria5CS3CzpzN5U=;
        b=o/Tz0jueoXnJLP3/zDWGdTeVOz+pK88O+rYLrgv+astNn9nyc+Gsh7nNMvpHag8j6R
         dyLiUreNWIh9u2CfyayqW2LkneyZcxLKuf822ORS/JcnrH5Sw40jivLodKvQgKIqEAbN
         tIROT/P3HTWbFaFRsANix/TcWzOLUO7Jz5zajmeRxxRkkyzVddWGjCCSm1e1UZ+mNMzv
         FYBkR7pdZnHBvn2Yn2HPdwCVdFH58TMx07f6qH3jtjgMokn4EiNmdz9uPYjQ0Jp6jHXP
         27XR90fe/W0l9EoOo+fTmiHvhfw5bjLaddySWOx4xicQUC6GYHBMBsn6Fdc2pCGIKzQt
         AcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722460315; x=1723065115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZvLSXSFJMkLNlj/PaF0YPjUuieX1ria5CS3CzpzN5U=;
        b=hBdLnEP5WMwz9jp/WVhM+hYrJDSH859yFL31PSPfNkMSLt/vVK1ihUHh8TDBfqR/Ec
         F1AtFWSfs6givEGNF8QG1AS++JehcOEN+ViJIdaavKxqnkPPUPAJNrXTT2jHs+K+AY2e
         oJacLGWcwaPvHthW2qN9kyg0KryxfR3DJ+vsCZOTS3w8bgQ4rXBXgZqcMdYzP8lipSKd
         qC1GfjZjXkuOq0/5hmNCM9hvi3LlR3+DS7YyEOb1GPTyoHcSUvTu9hyIV+tcXca7kBdy
         eemUK99JPxpjwq0GZs7y6H5NsLv2trea0/2WevgI9+srXEd0cu9c/zNiOtRgTb1gcCMs
         gSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr6gBjQ3nkAtSdgkcZN5grTku0wQI4tuoCkbrghlOCjObgZ2guIct/PbX5L8J79FvdoejfwAp+oTDvgZzd6WwlpeOQgaJpSQ==
X-Gm-Message-State: AOJu0Yy/FdtL1taFnp3YxCbK4OsU1y4oHBsl37qrgPojznSrlxuDv+mD
	fjEajlxGRU09FIBY3zz0l/43q+qpoxPGf19B58ybILX2LsDCoOCwBC48XLg6oRk=
X-Google-Smtp-Source: AGHT+IEdPF4xP7dgcasA1jodltKHHpm66OEBCOUHqXVM+e0xNPzRPKTZfGITIWaB4wlFOb3gt6ptYA==
X-Received: by 2002:a05:6830:610d:b0:708:f8c1:b901 with SMTP id 46e09a7af769-7096b84b7b3mr493240a34.18.1722460315099;
        Wed, 31 Jul 2024 14:11:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73ea990sm779020385a.55.2024.07.31.14.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:11:54 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:11:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: viro@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	bpf@vger.kernel.org, brauner@kernel.org, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 08/39] experimental: convert fs/overlayfs/file.c to
 CLASS(...)
Message-ID: <20240731211153.GD3908975@perftesting>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-8-viro@kernel.org>
 <20240730191025.GB3830393@perftesting>
 <20240730211225.GH5334@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730211225.GH5334@ZenIV>

On Tue, Jul 30, 2024 at 10:12:25PM +0100, Al Viro wrote:
> On Tue, Jul 30, 2024 at 03:10:25PM -0400, Josef Bacik wrote:
> > On Tue, Jul 30, 2024 at 01:15:54AM -0400, viro@kernel.org wrote:
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > There are four places where we end up adding an extra scope
> > > covering just the range from constructor to destructor;
> > > not sure if that's the best way to handle that.
> > > 
> > > The functions in question are ovl_write_iter(), ovl_splice_write(),
> > > ovl_fadvise() and ovl_copyfile().
> > > 
> > > This is very likely *NOT* the final form of that thing - it
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > needs to be discussed.
> 

Fair, I think I misunderstood what you were unhappy with in that code.

> > Is this what we want to do from a code cleanliness standpoint?  This feels
> > pretty ugly to me, I feal like it would be better to have something like
> > 
> > scoped_class(fd_real, real) {
> > 	// code
> > }
> > 
> > rather than the {} at the same indent level as the underlying block.
> > 
> > I don't feel super strongly about this, but I do feel like we need to either
> > explicitly say "this is the way/an acceptable way to do this" from a code
> > formatting standpoint, or we need to come up with a cleaner way of representing
> > the scoped area.
> 
> That's a bit painful in these cases - sure, we can do something like
> 	scoped_class(fd_real, real)(file) {
> 		if (fd_empty(fd_real)) {
> 			ret = fd_error(real);
> 			break;
> 		}
> 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
> 		ret = vfs_fallocate(fd_file(real), mode, offset, len);
> 		revert_creds(old_cred);
> 
> 		/* Update size */
> 		ovl_file_modified(file);  
> 	}
> but that use of break would need to be documented.  And IMO anything like
>         scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
> 			   &task->signal->cred_guard_mutex) {
> is just distasteful ;-/  Control flow should _not_ be hidden that way;
> it's hard on casual reader.
> 
> The variant I'd put in there is obviously not suitable for merge - we need
> something else, the question is what that something should be...

I went and looked at our c++ codebase to see what they do here, and it appears
that this is the accepted norm for this style of scoped variables

{
	CLASS(fd_real, real_out)(file_out);
	// blah blah
}

Looking at our code guidelines this appears to be the widely accepted norm, and
I don't hate it.  I feel like this is more readable than the scoped_class()
idea, and is honestly the cleanest solution.  Thanks,

Josef

