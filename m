Return-Path: <cgroups+bounces-13847-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEjuCcO1i2kKZAAAu9opvQ
	(envelope-from <cgroups+bounces-13847-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 23:48:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C964311FD1A
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 23:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 394ED3017DF1
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088530BF69;
	Tue, 10 Feb 2026 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfTG0Rio"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A4248F7C
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763710; cv=pass; b=ksPU7YskYyu4LaqerG6JvWJ1ztOu9zdrWyll7VK+5ZX22HOX76+NjQj+ZUpY7JZ+AGinNS+KeMgZgW56+bdmi2HzDweABbytDFOk+1BnHrtNReEkJDwt8bhaTCPQf7scRaU2tOtQsHb56TjYcJzrxfmGQn7qVXsE+bdbq5swShE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763710; c=relaxed/simple;
	bh=7RueDEbxvfiJY9nFUB8GTsk9UAZbqARgQdFKPxdici8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db5SFUgMTaXw1WuTe8NC2WY/y4i2B7PCgQHZfyifhJludr7PNepQdsnbAXQ3o2qeABAbef9v6YJNsTL0HlQ+5Um7Qkz65BkVWrUJzHXyZZRm0+XisHSDsUKSRkg83fY5udT/JF4LSXHmp+lUOBuwZ3nVurqW4ug0glbyxmIhwx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfTG0Rio; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48324da63b9so11415e9.0
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 14:48:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770763708; cv=none;
        d=google.com; s=arc-20240605;
        b=Cjjk5l+9N4sgbxG4sKnO6aPnYFOOGVZiPl818+lgW7eWFFFJ8q5e+U15Q2Qm9m3rWm
         na4oj3hdWSkqV+SYYjRgJDTGvhomPml9mBwGPIMyG99begp6sn1K+9yokUsFshSH3jl8
         EfvE6lTjtbg+NOQAlqwkTXRTRwGEYv5yxxp62fYbUc1hYA97D7dGSgMWifK3EQiu5sBa
         NoisQn0pIxYxA00Zj8xWm0pAiwTf2MFrZxVnguqcC2Upu5gDCXM2IJFdWU+2qF2NGwTy
         vuhPQAAMBHFaNL65qkGRx9ksukiXThz6KcpOkue7P6/8MRvKLqpvYDlWnFjOHj1aVhOd
         Gwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PuqeYntCSLTt3WclOHSOnzeNRZzfBKcRNCGgofm7tCg=;
        fh=CJucVIovN1ZN3UZUs41TF/pVBRU/d28L3z841cIAEyY=;
        b=lgXdE1FojH7mPNAkHY83XxrsmIbi0FO9eQ+81WADtMABpG5AHIJdF+aXMptk+ZrL3P
         uPSDxPzgB94RNVQZv85lbgs05q9HgpR694jIYCwDgFK4TFF5x9+r3op0EfTtvi1Ushdl
         Lg6UnBVbObPmM5U6rg+wAwUhZTbISXSnuVDJg7p8b/RRLG8PJ1bpjR+fWQrEpkJ4+994
         c1+1sKgjrYyyb8wcZP/gbXRaLUBoKrGhzzi76V4gTfgas8uEm+5yuuR4JLnoAJB/Ys3r
         b6ocUCUn73D9Z8fGmMKdg92sO1c+RBxj2daTNNsn/Y1Cp6uf3gK5iJBOEyQfPjhnYWim
         mHBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770763708; x=1771368508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuqeYntCSLTt3WclOHSOnzeNRZzfBKcRNCGgofm7tCg=;
        b=ZfTG0RioDJXR7P2P+zWbJpWvwOVBQLuMvOIrHH8oMTXOACHwbc6C5PkcN6avuZJugh
         yiXSQsl4F+KS0PhG75cdb1m4juEg48wK31FlnAjPxPJ2IoyRdJNtPScJy1tIFjipr3LP
         CS1PQbUi7hy/vIMscZeSoOB/lnpc35UJZ/oSH1ETTDwdOb/WzVYAKMsQ1H8rlpMXkbyA
         oPRWeldYOVk9LP/WrD3i/lmA9TN8sc6rGH4J8DO8el/NJGYKEPjN3Ub/bnMWK+SXhUXk
         0s+ZTDNg/EYhXryRXwxydjhQr8gxEEpvsHiiNOnW4ZH5h6mcM/eRDGshkfS+rxknEupg
         DNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770763708; x=1771368508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuqeYntCSLTt3WclOHSOnzeNRZzfBKcRNCGgofm7tCg=;
        b=ZdaSdeg8V2HPLiZmGT7vtIKOaxLrqA0Fw6/AmUZXGBBhMDlgtKP/o1pG81wtYyEsYz
         e3IHPENEt5uEXPvyLqlFPp6788BJpqie1bggaYHnhmb18G1TfxDzKsXnD/04MUjSjDCD
         YAVJcCpPYPZ9LrwQ+wgJgmHgxrDnqIf9HYflY0XncBi5l2OsYi4+nYUg9xc0n+BriWwW
         r2PwC/2A1sKihJprUyYVi+VzkJmsuYQzzk1c75qBS/kK+2Q+y/7dA3gVm9kWDWvqKMfu
         0m/WN3rewz8/V+g58KUevTDZCywEExi8aqTdn9fiBSyE62gNSh7vlwURXYN/RCWvqxcZ
         3PfA==
X-Forwarded-Encrypted: i=1; AJvYcCWZtFhWjgwMHYMo1nVwZloELKoprp5JafBNDovPG406AjpD7dxtuV0PjBdf6bBWNN/FbSDM7OJG@vger.kernel.org
X-Gm-Message-State: AOJu0YxIru2mLEcdngGgdWhIZ36ArScKsrKIYYy7jUaqW7ufcQsIS8Dw
	6CcSk/qQJF8AARzullF9hVQHB7aievrp8O1epFGoSmV9kOVqzj8oOLwH+JaMOGLoBdq0T4Str2M
	/b+dOSwC2Hoku+SztCKiZHjBvK1uMbp2zsyRPu+/M
X-Gm-Gg: AZuq6aIa2ZBPYnZuQpOAWMwHErXftLIhprDJQRLrcffiAPDOrip0HfqBVXwf0Cz1Qsi
	J+zxM4yWX77PYFYOXKxCenCO8Re2elX5vo6s7q4K/YS2T6d/r2Dog8/Xz6jvnowdLFaoPIT6rJW
	XwedHVh4laJDx8A5/5lFtQT7RFZmqYSIHw74IyQm1JKtHgt6xCZQuB73UFGzi/guUR84FZbpRh5
	xamla05UbFeCWPhhR/PUyNtGAQSAZIhiADLY9KRi5yLiiq+WVOlR1lTbjzZPptBoKNNbelQx1Y9
	QcFXNXuEolwHPHLLMPWeDWj1WAM8dPmgJPX3wE8i/cctD94H
X-Received: by 2002:a05:600c:1492:b0:47b:e29f:c63f with SMTP id
 5b1f17b1804b1-4835cebf7ffmr48345e9.11.1770763707610; Tue, 10 Feb 2026
 14:48:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210003801.2834976-1-tjmercier@google.com>
 <20260210003801.2834976-3-tjmercier@google.com> <aYu0WZ-xCZr-bmsq@slm.duckdns.org>
In-Reply-To: <aYu0WZ-xCZr-bmsq@slm.duckdns.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 10 Feb 2026 14:48:15 -0800
X-Gm-Features: AZwV_QgfVPfvMntqiVCLNCIUNKNlybv8eQNNTRFicqch08xd5Yhkj2QTYq81v9w
Message-ID: <CABdmKX36bog6EvLd1bkGk+hd8FyPqjgqGZZ3T1gvskgvjZGxmw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: Tejun Heo <tj@kernel.org>
Cc: gregkh@linuxfoundation.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13847-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: C964311FD1A
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 2:42=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Feb 09, 2026 at 04:38:00PM -0800, T.J. Mercier wrote:
> ...
> >  static void __kernfs_remove(struct kernfs_node *kn)
> >  {
> >       struct kernfs_node *pos, *parent;
> > @@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *k=
n)
> >                       struct kernfs_iattrs *ps_iattr =3D
> >                               parent ? parent->iattr : NULL;
> >
> > +                     if (kernfs_type(kn) =3D=3D KERNFS_FILE)
>
> kernfs_type(pos)?

Oh, yes you are right. Thanks.

> > +                             kernfs_notify_file_deleted(pos);
> > +
> ...
> > -static void kernfs_notify_workfn(struct work_struct *work)
> > +static int fsnotify_self_event(int event)
> > +{
> > +     if (event =3D=3D FS_DELETE)
> > +             return FS_DELETE_SELF;
> > +
> > +     return event;
> > +}
> > +
> > +void kernfs_notify_workfn(struct work_struct *work)
> >  {
> >       struct kernfs_node *kn;
> >       struct kernfs_super_info *info;
> >       struct kernfs_root *root;
> >       u32 notify_event;
> > +     u32 self_event;
> >  repeat:
> >       /* pop one off the notify_list */
> >       spin_lock_irq(&kernfs_notify_lock);
> > @@ -929,6 +938,8 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >       kn->attr.notify_event =3D 0;
> >       spin_unlock_irq(&kernfs_notify_lock);
> >
> > +     self_event =3D fsnotify_self_event(notify_event);
>
> Maybe just inline the conversion?

Sure, sgtm. I figured the named function was a bit more
self-documenting, but it's just as easy to add checks for FS_DELETE
where self_event is used.

> Thanks.

>
> --
> tejun

