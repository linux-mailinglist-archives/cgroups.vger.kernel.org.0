Return-Path: <cgroups+bounces-8447-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E2CACFA89
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 02:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F341891269
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 00:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C96B1DFCB;
	Fri,  6 Jun 2025 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMpgh6nl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3E1BF58;
	Fri,  6 Jun 2025 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171270; cv=none; b=CrgBsirsiu3VIT4YZ793prNXh4F9qrjsXnSUJot/uRwZCEJ0MOaY8Zq61KKMa75r+twVk8FPSh8bMBrhysFzqIv3ANND41KtZeQR3sZ3SSGZPJueoILRHuyLr0vSNM1rO/SM+I/RRx6SAqBGhuvHQbTEjhaVuNcQSDzmmgH10sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171270; c=relaxed/simple;
	bh=XcD3CQpM2fvCnfNAEiJRLLE3yyVHesdRZ7FGaMCES3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cjz5HMQx/ZYzXJefENEceByglSD/9jNZ7c4wX5l2jgxAy9NbRnW56CwzkN12Lu41kCR5YOMYbEGQrkv5JBOlDDIU68rQsxOH95jifwvMOhn5mhYRmrxOExpljn/JbI8eoA2Yv3RlqVtiIBori6KS/cehcMOtsVTvytlXwyiUjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMpgh6nl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d6ade159so13684245e9.1;
        Thu, 05 Jun 2025 17:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749171266; x=1749776066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2rwrhWlVtJKNsIdoVp8QiZ90VZN2RBKrVsrx5vFTF4=;
        b=dMpgh6nlOHoDWpl9ADn9kas15UVlFE1CdgytkFgP2d3fgup0o5X+3tUvlGdMIxdhBv
         mkjD/txWnhe2kLn/b2Uk8/wSDAGbY1wIBRNL6/Fd4oo+WbFpTjdNTR8vAEUGEHbcd3gW
         FBJ7lTXoZN4NtqstdJdYO3X6eBagJfhI3HJQwBmrwlauuWKIVVLYggTCEneT+luFY3Zp
         0coodHHO1PoHXu7y1KA52MsEc8F3m6Oak8tBC5xAql3DlN8/CStOHCEfdcyCgrmWCy87
         j7lq6gSqAaurdtVjwYsVLhhy1DxMuUS2nDZAA4v6oGzGxGLMDG+5XJ7fLwXYyLiSRk+/
         /2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749171266; x=1749776066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2rwrhWlVtJKNsIdoVp8QiZ90VZN2RBKrVsrx5vFTF4=;
        b=jcO0suLPzqUqe8btI3dg403MRM79E+/wD7d2gDqZ4+cmxiJidJXXRwK0p7n0Pz+hzk
         1pLBAD63Wj6p7aav6Q7ZdkXM0lBaqx4MOmXg0cnvvL056+b1b955O3zRBtDesiqbGwwR
         VYeq13xbRo5bSEGdvbFS/XgM47WlfSrw6RLLlmWvyvWjTo76tKCV1sB3PticFXcoq8GY
         mwfOokHR9ZCYygr0OjhYhbKOehep8/zZCfjBQeBi1U3fE7adHSwsianKygao8WgmdpaY
         4WaweFN8IAXVZxg0nvkoxFsiUVrPxcfEQ+zwCGDeFxmBdgyMace2ORlWM+D1KKYD4yuO
         kC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUY7meU86yVv+rq3YQRS6hvKPh0xs5KSAvqBYDRVcDfdK763lCMPBRywLkvBjy3oxk5MxDWBQDH@vger.kernel.org, AJvYcCVhSW8L15MfQXK7WBY9rfnM1fvNmafOoZZ1B2nXud/uEgEKvB2MVPvse+qnr/mlbPNyiit6+2+8eFmsUqff@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/oTMus2Xvbthr16jTbPMJSz5bSQuwBLeDI+pJy4w9BY3kR+z
	kp0/uxL+5MTmYUfvISt69vPdPMqAtkeGW/ZB6B3yZ4Dv8qlQB4eOlJ3jHWgOsVMO9KnCQOYREJP
	BJtufBZw9RqWOAmcoS/Ul/EPvf1d5zvU=
X-Gm-Gg: ASbGncuMelR7cGlxCNz/KcEZyir0luRm49bkcNlDlWQ9OvgbIxH7zKm5bDTI6RJsmqE
	982mNp9/3vEqvCfvHB1ADSxcH7Dbu5H6l81iAXiY8zDohIbtpJEDnKPYXyfPyQWUMTD7kO4arPx
	doj6D5IxcQgkC7DLEMY7kZPUyavkaEf8qFs9Yx2Q+6KoqCGrlUx3AIYrQzCEr+YA==
X-Google-Smtp-Source: AGHT+IH1dtOra6TUqOMybdYXVeTmKbd4hEyDG2gvQ9kVL4NVBlNw30HPRXxgTCtQtLrNw0Ph7XRAIClCNgt72e/X7dA=
X-Received: by 2002:a05:600c:34c1:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-45201436a61mr13431415e9.29.1749171266466; Thu, 05 Jun 2025
 17:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605211053.19200-1-jemmywong512@gmail.com>
In-Reply-To: <20250605211053.19200-1-jemmywong512@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 17:54:15 -0700
X-Gm-Features: AX0GCFvsDf8E-bJ5xoX-vPGgtym_KVcgJT5fKhu-2duLhqId13vjSDkBfC5K6lI
Message-ID: <CAADnVQJyATTb9GFyBhOy5V_keAO5NZ6+zucLRyN27Cmg2FGPVA@mail.gmail.com>
Subject: Re: [PATCH v0] cgroup: Add lock guard support
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 2:11=E2=80=AFPM Jemmy Wong <jemmywong512@gmail.com> =
wrote:
>
> This change replaces manual lock acquisition and release with lock guards
> to improve code robustness and reduce the risk of lock mismanagement.
> No functional changes to the cgroup logic are introduced.
>
> Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>
>
> ---
>  include/linux/cgroup.h     |   7 +
>  kernel/bpf/cgroup.c        |  96 +++---
>  kernel/bpf/local_storage.c |  12 +-

Nack for bpf bits.
It only uglifies the code.

