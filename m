Return-Path: <cgroups+bounces-1953-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A361586E7BC
	for <lists+cgroups@lfdr.de>; Fri,  1 Mar 2024 18:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428E2285614
	for <lists+cgroups@lfdr.de>; Fri,  1 Mar 2024 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73AB11C87;
	Fri,  1 Mar 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PFjLRZ6n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB55848E
	for <cgroups@vger.kernel.org>; Fri,  1 Mar 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315519; cv=none; b=rupSC3f63uDZmW+smc+MqrSPykTaJY5nj7ckJUq6h1yhcjurtqBVokuIvcAndhVdARHsHQdbnA4a6Ynzy59DrFMU/LbnUKqXaURRQP43BYa5eliX2WQnD4i/Mh5J5f808sCHb0aOd7FaQiuaJ9jNTzOevaOxqV2bfaYQjZZweio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315519; c=relaxed/simple;
	bh=49XDVc09oo1D7rxA4pKGXs7kZYjPBKw7n1z6bPxN2O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4ffaN4qWk7/dToqHOXifpSCXlk0r0Eu1iObcVOiun/Wn1PQxg2ier8YSfkJ8/N5VgAqgTbY+iSbQ90li1hAApnOXFQkZmXLFUCCQPCmd9v8D7WcaxYsXO7GYEUa76K1CAOx9Qz86aHLGrqvMAdmLOMUreq7HNmUVZv+n+VkVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PFjLRZ6n; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5132010e5d1so2520811e87.0
        for <cgroups@vger.kernel.org>; Fri, 01 Mar 2024 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709315515; x=1709920315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzMbDkgTXsN2/951Q9RWiF9r9QR8HrSOWMnrlfRXcYc=;
        b=PFjLRZ6nGmqMCp8ZzmNjDoCM2t89j+RdR0Za/FRYNx0n9Gog1SVfOOh5jho4gBaxzQ
         J3Xe5bwHQ00wsEMVR+c2X7FnzrgIH6fuHO3WfSyWAmCC56vCzf5NCaEp3AQz5x2mtJHW
         sd9NKuUAxeEyPs/kfYMCZhuM6tcPaZW6tE2QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315515; x=1709920315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzMbDkgTXsN2/951Q9RWiF9r9QR8HrSOWMnrlfRXcYc=;
        b=vCZZ13apmIQGsvH1/J2UjhhboBZXcJWF4hQen+iMcdvgtFdR/SzX6PTcTKB7fFgaXD
         xUVDJGIx/bIkk/pokuf+0kop2LU0LIcfBmx7Pn/MImamYSfuHjOwUbqi7zkYW+jDChvv
         MN/T2KRHN70aHMw9SuOSQzw/4aSykCiNkzvLQ81yV5v0BdA9EFbwQYMyCgZq7jeFIUUU
         siz1GymAPnHBl2e57o2t8c62r0pCtvHhLTM+B3WXpCuUx8fjzfaJylnLsyGShH175LlV
         1a6d5keR8ICaOUOe+JKunk3HjpnID3ZGccn4qv0GTUn4DKR0GaeCQ4NGvwB5xQR02U3o
         Pj2A==
X-Forwarded-Encrypted: i=1; AJvYcCUfFgSxTZwURUlxemnzUkb8FZaBJ8mEXh8VaU5QKsseXtxFzeT/Trc4FDDxxVQWw4xsnGJ405XQ/DMN0zLGdswXEKBzeTungw==
X-Gm-Message-State: AOJu0Yy8qlR6CNPl2uC1/yb2SGinQRogV4mxSI5x/3jJS5c4CKj39+3l
	FQ6Ti/ShpyNV7rk0ct8TIeZ8q94l+aOQGcDiuJ29/Ky5MQVIuGKbhmk/7Lhp6cTvzdbMx2wj03l
	aNvbx7Q==
X-Google-Smtp-Source: AGHT+IHG9wgdXgBgFAZQHPoWXWcTFY/QRkFgUGfSbvaa7ESKn+MnAFDcazDDGYYkry6hwdwSar3fXA==
X-Received: by 2002:a05:6512:4013:b0:513:177e:4254 with SMTP id br19-20020a056512401300b00513177e4254mr2069931lfb.14.1709315515632;
        Fri, 01 Mar 2024 09:51:55 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d1-20020a193841000000b005131eb404cfsm700119lfj.117.2024.03.01.09.51.55
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 09:51:55 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513298d6859so2076394e87.3
        for <cgroups@vger.kernel.org>; Fri, 01 Mar 2024 09:51:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8YKewH9Oy8qnE5d10PIYy2Wy/a5p1A9Cu8xgDoZ601sm9gz6pGXXDm7DVj12vy0iudiU6iRFaTI6F4tgIefgSDy/IYmYvoQ==
X-Received: by 2002:a17:906:5a9a:b0:a44:48db:9060 with SMTP id
 l26-20020a1709065a9a00b00a4448db9060mr1596114ejq.19.1709315494643; Fri, 01
 Mar 2024 09:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz> <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
In-Reply-To: <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Mar 2024 09:51:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Message-ID: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in path_openat()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 09:07, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> This is just an example of using the kmem_cache_charge() API.  I think
> it's placed in a place that's applicable for Linus's example [1]
> although he mentions do_dentry_open() - I have followed from strace()
> showing openat(2) to path_openat() doing the alloc_empty_file().

Thanks. This is not the right patch,  but yes, patches 1-3 look very nice to me.

> The idea is that filp_cachep stops being SLAB_ACCOUNT. Allocations that
> want to be accounted immediately can use GFP_KERNEL_ACCOUNT. I did that
> in alloc_empty_file_noaccount() (despite the contradictory name but the
> noaccount refers to something else, right?) as IIUC it's about
> kernel-internal opens.

Yeah, the "noaccount" function is about not accounting it towards nr_files.

That said, I don't think it necessarily needs to do the memory
accounting either - it's literally for cases where we're never going
to install the file descriptor in any user space.

Your change to use GFP_KERNEL_ACCOUNT isn't exactly wrong, but I don't
think it's really the right thing either, because

> Why is this unfinished:
>
> - there are other callers of alloc_empty_file() which I didn't adjust so
>   they simply became memcg-unaccounted. I haven't investigated for which
>   ones it would make also sense to separate the allocation and accounting.
>   Maybe alloc_empty_file() would need to get a parameter to control
>   this.

Right. I think the natural and logical way to deal with this is to
just say "we account when we add the file to the fdtable".

IOW, just have fd_install() do it. That's the really natural point,
and also makes it very logical why alloc_empty_file_noaccount()
wouldn't need to do the GFP_KERNEL_ACCOUNT.

> - I don't know how to properly unwind the accounting failure case. It
>   seems like a new case because when we succeed the open, there's no
>   further error path at least in path_openat().

Yeah, let me think about this part. Becasue fd_install() is the right
point, but that too does not really allow for error handling.

Yes, we could close things and fail it, but it really is much too late
at this point.

What I *think* I'd want for this case is

 (a) allow the accounting to go over by a bit

 (b) make sure there's a cheap way to ask (before) about "did we go
over the limit"

IOW, the accounting never needed to be byte-accurate to begin with,
and making it fail (cheaply and early) on the next file allocation is
fine.

Just make it really cheap. Can we do that?

For example, maybe don't bother with the whole "bytes and pages"
stuff. Just a simple "are we more than one page over?" kind of
question. Without the 'stock_lock' mess for sub-page bytes etc

How would that look? Would it result in something that can be done
cheaply without locking and atomics and without excessive pointer
indirection through many levels of memcg data structures?

             Linus

