Return-Path: <cgroups+bounces-15266-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO0NIoGt3GnfVAkAu9opvQ
	(envelope-from <cgroups+bounces-15266-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 10:46:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 260BC3E94AE
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 10:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A888301CC5C
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570735A397;
	Mon, 13 Apr 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlifcbZO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sg3/fjAL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10FA3AC0C6
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069998; cv=pass; b=ET/ags5+8LwXdWvdU0OelgupnwRzCnY7j9WyaTjUBltbke3d/xS3xdbOs9NLnTCT2DH8feplBU8bQYwjWE3Jro6dofyfLppZylcTHcHKeIv0YJpx094MOJMp4sbjBNV/8fPnO1pTChH4R6Si61djtUYqO6iLH1jTo4Q3oANIwCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069998; c=relaxed/simple;
	bh=51K1dSOwx77FUDK5PTj+zi2/Idf/3F0Kn/F+IWkeRRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5e7u0qUTqMauoqdwOgXaJuJ3ItIvTSCHvp0JcSoS9mhVzr0fIgYIm3VtZZKrg8mFDGzC9HPUx5Aw3KKkvBTmm0FsCnTQOpU72sg/Y2fpWTfC2o8inagRC+BfmTPhBwuP27NLAO9gOmZqdNTjneo36N+09gaLA3wOgT4b1w+sDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlifcbZO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sg3/fjAL; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776069996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0213UnEMOod9W6HJe+rSGORixl1p8NPdPniRuWrrH0=;
	b=OlifcbZO55P92m2QNBhlREE7cdhfVlEyap8L8UH5wJmax9qb7i9wfqDSUg3qWAjHl//4st
	TDrP2cnN5ubzeh7JsqkjNyon7soBpe0J3d82YptTU14jGasnJnQX5cfwAKIi5xuC2kJ8MM
	WQxInbVsxYSNhgMHcBasGFBXWTkl8wc=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-KmXAIoGNNfCuJMqfSFl6ZA-1; Mon, 13 Apr 2026 04:46:34 -0400
X-MC-Unique: KmXAIoGNNfCuJMqfSFl6ZA-1
X-Mimecast-MFC-AGG-ID: KmXAIoGNNfCuJMqfSFl6ZA_1776069994
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5873607eec.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 01:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776069994; cv=none;
        d=google.com; s=arc-20240605;
        b=hHm60xhkpq9GT74AU7UGsfkt91fOfzwCuofCbzirJdaoNrlYgV8t7i85gGJQ/YaZ7v
         ZZ73g+OR8fosN6XeQW8HG6qaIo+T4SYuUcQ7kxB3cBnaYWpzlCdJAWSYwl+yXs/QQcM0
         aUd4JAiIoTl0e8TG9xXM5/aMDP779seJFvrzJvPKfMxBXZQbV5e/XlQyFQ9cdX9PkEr6
         zvTISNHsFjqA43E28eifZE3PrQgGK/OL9iOJSsUSGXBXHJBIR9d4+08AxG+3+8Veos9x
         WNavZ8+j7WAyxdrweIIQchUTVTbrSZSYNeqXEN5zFrVYp+TuVMAuKaHvcU2DixO86fSO
         0GPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o0213UnEMOod9W6HJe+rSGORixl1p8NPdPniRuWrrH0=;
        fh=e+fiePkYVwe4PON7Yt0rRs768exwsYJWZAal9LR8i/M=;
        b=NFgZlTHVdulZO3eqFZKa//eTXblXC4fj5awNhkFXxEUFBG1rb2t5+KD80ytPHIO1zu
         rA60pAzPaz+pN4348wwabmzPRyzzikoyoyfdjoYd7RnDqQTeW7u2h+MSPnuA72EyWFAR
         OpAHbMewjrHk83tSLkHbIXGxXAHu8rRNatRYI5B3RHizEIu4VErKP2xfk3uLCN81z6mH
         4jONaHj0Uu1sjegs4asZhZsPuFgAeIbhIvcsjQ1m1nq+eRRGgSGKaPtY8EPl1MkUJqDm
         OPaHx11VwuXVCHsOgbuJa3zWc3h8xSlCLcce1VXupnDEyAWqDdGIIT4UIYencBmE4yC2
         fP6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776069994; x=1776674794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0213UnEMOod9W6HJe+rSGORixl1p8NPdPniRuWrrH0=;
        b=sg3/fjALBCyWq53sVuvJqSZ0Mo54qT93H9VUdUEpxlldiDlX0rYKmt6fyxrekiE+zs
         6gNfOQ66rFNc1csRphiz4bwHydDCJr4XZgTeJ+ASxr9XEataM6fLAvc58Be1HCxxzNog
         LiRpFNPaoNulSRnweCsQs9vaK+3FLLs8ipoZ2ZxihxVhNCc2Jy7mPhn51ASdVwxMNl4L
         gk8CsBUVx8B7rsLewTaQWElQrWesaCV5sXk8fEiAl5sWOj9A2M8OspkvKROmNJtPbWDJ
         aeSkcW7N3cJxWwHb2WmHEBVR7KDqeiPROU9utf0MExb2DYMakTlHkODQktHKSR3bCj+T
         XQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069994; x=1776674794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0213UnEMOod9W6HJe+rSGORixl1p8NPdPniRuWrrH0=;
        b=i2GvL6nErtwc3NudFHU36zAeOCzx7cMWw812gA0GrDwZiUWprGVdkYFD5zxSPESa6N
         szFsq3fQ5HApgRIACnU8UBvkmiG5Jlpf9PH1EH+kO2SqMkTgJMpEY6mq2fXSqfp4WuTq
         a7/GUkfUltS2riPBPefCmnO3QPfZazIxEP8PNvQ5dInLimyyEl31cZAg45xw4u1F1KLe
         +0dsEmPzYzXU9CwXc2SQto+ymaiirjnWtO5UvtSvdC2GQYd74SOwX4xFo8KK/N2YaiZD
         8BPflAqQul9r4+Tdxpby/1MfMJ756/wyPWya7Ym9WoKpjJ58j8jDDipuiOZIyl7uSm5g
         rgMg==
X-Forwarded-Encrypted: i=1; AFNElJ+Zp4W3455vRH+5PJIE0D0xB5WsWMyeoXIksho/AtuxWMrIO8eiN/5xGnGd+odpC192UvUgcT5g@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCqYKtAwGqk3RfsZPXVJMMIp3hU/7hgJX6rik7DWCpCVQhELa
	Arj/5R+ffRNZ3yXNP6Ggtlel+TzPMwiIfcHR+FRUpDfVjPAEbuUPWYVaeLYcCoSLLna2JeBXmLW
	FDIGm3JJAx+TRL4hNKhirybPQnkdPphs+KTOix1MP8ysanNx0vxxThPeg111YpOlslVVAn1WHc9
	Dk6+yzldiGATrNzLW4rUZz6Lg0pP6sm+GZXw==
X-Gm-Gg: AeBDievDBqll5Zpg7e+jViyAY8qAQtT2RtgOv+FC5+X4sVKJ2l9yKsyTycaZiCxm8+y
	p3zT1uGJitAXsW1UQMY1BrtbJjH1uuhSFz9maoGlKICP0EdQaWppLAnOaT1uklce8F7veB6fAFK
	S8UZnAYi3a9G3oW+tS0SuUrdFFWyglP9OThlY7IRkHIHRCRg7tNIvabadgl2ML6MDHgqOp7JhED
	IiTeg==
X-Received: by 2002:a05:7301:fa0e:b0:2c4:b8d6:45d3 with SMTP id 5a478bee46e88-2d5877991cdmr6669860eec.10.1776069993416;
        Mon, 13 Apr 2026 01:46:33 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0e:b0:2c4:b8d6:45d3 with SMTP id
 5a478bee46e88-2d5877991cdmr6669840eec.10.1776069992889; Mon, 13 Apr 2026
 01:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402063714.55124-1-liwang@redhat.com> <20260402063714.55124-7-liwang@redhat.com>
 <CAKEwX=M150Hw0Ncs69SCWRr7J+vK5F0biotkz=MSFvFG3rgjow@mail.gmail.com>
In-Reply-To: <CAKEwX=M150Hw0Ncs69SCWRr7J+vK5F0biotkz=MSFvFG3rgjow@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Apr 2026 16:46:19 +0800
X-Gm-Features: AQROBzATy_Du7HEcqoEpfm3ecefJ913kdNeZVB-cXtC9R6JcAITrAGqsNlgA3uk
Message-ID: <CAEemH2e76jseObPh5oj7H7KB9kJeucWeb5zSy_f74YMy-HcShA@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] selftest/cgroup: fix zswap test_no_invasive_cgroup_shrink
 on large pagesize system
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, david@kernel.org, 
	hannes@cmpxchg.org, yosry@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, 
	mhocko@suse.com, shuah@kernel.org, chengming.zhou@linux.dev, 
	longman@redhat.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, liwang <wangli.ahau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15266-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,oracle.com,suse.com,linux.dev,redhat.com,kvack.org,vger.kernel.org,google.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,linux.dev:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: 260BC3E94AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 8:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Apr 1, 2026 at 11:38=E2=80=AFPM Li Wang <liwang@redhat.com> wrote=
:
> >
> > test_no_invasive_cgroup_shrink sets up two cgroups: wb_group, which is
> > expected to trigger zswap writeback, and a control group (renamed to
> > zw_group), which should only have pages sitting in zswap without any
> > writeback.
> >
> > There are two problems with the current test:
> >
> > 1) The data patterns are reversed. wb_group uses allocate_bytes(), whic=
h
> >    writes only a single byte per page =E2=80=94 trivially compressible,
> >    especially by zstd =E2=80=94 so compressed pages fit within zswap.ma=
x and
> >    writeback is never triggered. Meanwhile, the control group uses
> >    getrandom() to produce hard-to-compress data, but it is the group
> >    that does *not* need writeback.
> >
> > 2) The test uses fixed sizes (10K zswap.max, 10MB allocation) that are
> >    too small on systems with large PAGE_SIZE (e.g. 64K), failing to
> >    build enough memory pressure to trigger writeback reliably.
> >
> > Fix both issues by:
> >   - Swapping the data patterns: fill wb_group pages with partially
> >     random data (getrandom for page_size/4 bytes) to resist compression
> >     and trigger writeback, and fill zw_group pages with simple repeated
> >     data to stay compressed in zswap.
> >   - Making all size parameters PAGE_SIZE-aware: set allocation size to
> >     PAGE_SIZE * 1024, memory.zswap.max to PAGE_SIZE, and memory.max to
> >     allocation_size / 2 for both cgroups.
> >   - Allocating memory inline instead of via cg_run() so the pages
> >     remain resident throughout the test.
> >
> > =3D=3D=3D Error Log =3D=3D=3D
> >  # getconf PAGESIZE
> >  65536
> >
> >  # ./test_zswap
> >  TAP version 13
> >  ...
> >  ok 5 test_zswap_writeback_disabled
> >  ok 6 # SKIP test_no_kmem_bypass
> >  not ok 7 test_no_invasive_cgroup_shrink
>
> I assume the test passed after fix? ;)

That's right! This patchset is targeted to thoroughly fix various bugs.
I rerun it too many times on various arches. All works well :).

> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: Nhat Pham <nphamcs@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > Notes:
> >     v5:
> >         - Swap data patterns: use getrandom() for wb_group and simple
> >           memset for zw_group to fix the reversed allocation logic.
> >         - Rename control_group to zw_group for clarity.
> >         - Allocate memory inline instead of via cg_run() so pages remai=
n
> >           resident throughout the test.
> >
> >  tools/testing/selftests/cgroup/test_zswap.c | 70 ++++++++++++++-------
> >  1 file changed, 49 insertions(+), 21 deletions(-)
>
> LGTM. Thanks for fixing the tests :)
>
> Acked-by: Nhat Pham <nphamcs@gmail.com>

Thanks a lot!


--=20
Regards,
Li Wang


