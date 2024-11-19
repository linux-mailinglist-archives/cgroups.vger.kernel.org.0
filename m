Return-Path: <cgroups+bounces-5645-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288F19D2EE2
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2024 20:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB924282C7F
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2024 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D053A1D2B04;
	Tue, 19 Nov 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdXHSl8L"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C31D0F63
	for <cgroups@vger.kernel.org>; Tue, 19 Nov 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044986; cv=none; b=k4IqHjplagZFIB6pil+KeX2bBTJLL2jcKkt2kjO53haxT+C6ZAF+4Zk5XlpLsa/C78ocg1Ascmn3vUZEMkY1uxg/BKKyDIym+lo64dGZzLlX9/nQeUeCIeYcuHS8+XhTpfxL8n7P7aPYy6V/l31SARVgROgVIL7xMjYIbNPu/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044986; c=relaxed/simple;
	bh=Wim9yXigya11JzSJv1LJSiuLfLQF8F9N8fBEX0Njam0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7FwmH45tZMkHHlsfxrKIBK7cNcnRWKWrzq1aVv9qVXeA2xqYcHkWWy3U30RpZ38lat5ivijyzEZAknGiffmxoozsDahuGsliDWSMgfnZHLkvxsfeyWUuOSRkXj9N7ZFhmrJN0Ku4R+PmIYg4AEhGNKcMp4yotahTobLIBG2Tlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdXHSl8L; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d41d46162eso15956086d6.0
        for <cgroups@vger.kernel.org>; Tue, 19 Nov 2024 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732044984; x=1732649784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rBH3J51JmQt7kWjmFFHSB4td0hJaQgPAm0Yx+WNjx8=;
        b=DdXHSl8LuUijNYK7qzPKoZvjP9q0QWfVjGRTszcESOzpFVHoy0qGqPa3cCmya+riu4
         fcFmCZ3nf7ZgZJCFK9q5UZvkC9MCtRNFPsTEwjky8ytLGBQBEg2p865buM7h1pKIPLQX
         cXPcu8OK+629bKTH6btr2T0V5ZGxMfa983w0eZwNPv9X6LiTYFczP18a8unOWE9UngHa
         ixYNitvUu6JO72BSjjXw7eP9C7vy/UEsMOK+O3+emrort7DbW7X5t4Gsqn01cTMTVzIN
         b2aTvXeT5BlJ1N6rCH9gQsmHw/u0PqwdHrF1VmPuMuqRWdjZA6J7xu0Um8d85Ke0vm50
         x2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732044984; x=1732649784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rBH3J51JmQt7kWjmFFHSB4td0hJaQgPAm0Yx+WNjx8=;
        b=ZT5EbTfVv71HAeYG2+dUsgJGnKziYdYxAyXgcilhf7O2QubJsJ9XOncE1+xjrXMeLL
         sqoSWaQy58jCR+8uSiwe3vCUulzIhP8ALBSjNBQOjlIijxkoGeHpgaXJXbGRHN2EWzid
         p6wu2WM2NhSMdcZFtkZSuRs0FaxNyfQhd6KtXe+h6LZ+ANb5bjPLU6D1Q8bcVxkohfF1
         EeMUx9xtmVrrK+TOMozeU1TKPEyE451cI6rzq2n5lZcbBpB6hlxmi+O2CLSIyRRP78Vi
         9lIRSGLNf6Me7XSuvsQqhM8uD2mvrYPYX20L1+fnk7BmW4y5UWSNQPS9eltOAd6JonJG
         +Mtw==
X-Forwarded-Encrypted: i=1; AJvYcCUXZoAqS1IobcWtkvK9k5+wKMAuBSe3NOH+OcCNRUv0GjKzuLXBd9WvK46DZ8c04nGumDXTfKQm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RY0/7NKcT6IecI7Cm6gjT3Pm7qYUClfk7n/anpxiZIUqFdCm
	hTtUNEF5CBAWs9w3gtW+kD2z6c4+4zJaXXM57QnAlN7gkDD5V4SLj7XE0s+Yl2jy1Yy51KQ6rNH
	+BI1GU5qRGYg+DfcVoMe/b9gqcSPTpmzoEgRh
X-Google-Smtp-Source: AGHT+IEPHfQ345gIVazfS+BM1S3fQuD8LMdzMQG/6NL1BywFYIUVmX6NNojvADb+a4swnafGfVK59ZDkwp15Z3Sszpg=
X-Received: by 2002:a05:6214:2583:b0:6d3:7a47:2034 with SMTP id
 6a1803df08f44-6d4377b32b5mr2495396d6.3.1732044983607; Tue, 19 Nov 2024
 11:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com> <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh> <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
 <ZzzXqXGRlAwk-H2m@google.com> <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
In-Reply-To: <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 19 Nov 2024 11:35:47 -0800
Message-ID: <CAJD7tkZDSZ4QjLhkWQ3RV_vEwzTfCMtFcWX_Fx8mj-q0Zg2cOw@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Tue, Nov 19, 2024 at 1:23=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> >
> > On Tue, Nov 19, 2024 at 10:08:36AM -0500, Pasha Tatashin wrote:
> > > On Mon, Nov 18, 2024 at 8:09=E2=80=AFPM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> > > > > Additionally, using crash/drgn is not feasible for us at this tim=
e, it
> > > > > requires keeping external tools on our hosts, also it requires
> > > > > approval and a security review for each script before deployment =
in
> > > > > our fleet.
> > > >
> > > > So it's ok to add a totally insecure kernel feature to your fleet
> > > > instead?  You might want to reconsider that policy decision :)
> > >
> > > Hi Greg,
> > >
> > > While some risk is inherent, we believe the potential for abuse here
> > > is limited, especially given the existing  CAP_SYS_ADMIN requirement.
> > > But, even with root access compromised, this tool presents a smaller
> > > attack surface than alternatives like crash/drgn. It exposes less
> > > sensitive information, unlike crash/drgn, which could potentially
> > > allow reading all of kernel memory.
> >
> > The problem here is with using dmesg for output. No security-sensitive
> > information should go there. Even exposing raw kernel pointers is not
> > considered safe.
>
> I am OK in writing the output to a debugfs file in the next version,
> the only concern I have is that implies that dump_page() would need to
> be basically duplicated, as it now outputs everything via printk's.

Perhaps you can refactor the code in dump_page() to use a seq_buf,
then have dump_page() printk that seq_buf using seq_buf_do_printk(),
and have page detective output that seq_buf to the debugfs file?

We do something very similar with memory_stat_format(). We use the
same function to generate the memcg stats in a seq_buf, then we use
that seq_buf to output the stats to memory.stat as well as the OOM
log.

