Return-Path: <cgroups+bounces-13907-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG+WBUcQjmkM/AAAu9opvQ
	(envelope-from <cgroups+bounces-13907-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:39:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B28130004
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E14E3013471
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDC12638BC;
	Thu, 12 Feb 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/QQM+VG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58D223DFF
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917956; cv=pass; b=DKJ5e/krH4rBEtNwy9LdoN0H0YPc3ZQN4namXXxizdqho+3ZuIxppLtBzuaUh4kZr9jLOvJGDLgATZkTuh0JCUs2W2BtsSp4Dm2jitF6ipJUKMBF2UtR3jIDuSx+rQh20bNtVIS2NEons9mT0w40MUy8PZ/I+IfX97YwHAV98Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917956; c=relaxed/simple;
	bh=PmDSu9rHdkQKCyukTIemQGDTasI1Oy6wKb2WDyCVFJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQu0Ig6yPmyKNpTIrHwwRS9oK/8sJkC1HBxFP1j+uszwN33vsMhMVUtx7oNdLnBo8OAGiA9G/LwFg6Zt5/4ZVj8peSQHJXEy+McyetQyJr1Bu97PJsMJ7udeuPxE/Val9rb5z70OoQZYdGyBnYpVzv+OVxWGzdgTCxyXwHBS+h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/QQM+VG; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43591b55727so121934f8f.3
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 09:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770917953; cv=none;
        d=google.com; s=arc-20240605;
        b=YHXBzvShpaq0thudptYOzvRTM2YPZYfsQesmrzsMSMitsN8XRAXc8helkaGDXVevHQ
         /GzqSJmEaJyuLdx3BiN8iuxnyoaaYmCKLb4n6E3n8FIgIXHt5ZZ+FqiR2fbxEHBnQ8H8
         ffEOeObRULbKGf4HLA1EyPgaqSUlbaSTefiKG8aUbBHU73BcClhItOjvUI/NoQoqioI3
         Q9AQg/o0iMkeYb/+ozK6JeOW8RG7BfaImEf8sT3E0y7gZPjbZAOKzZrdXz/GNv41wFXD
         f3bIRZDYiHxUiATIeKrYuErYIPOGM84Upy7d1gSdNgNRwddn8oV/h4Og6ezdVv8YCU9r
         ufDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PmDSu9rHdkQKCyukTIemQGDTasI1Oy6wKb2WDyCVFJM=;
        fh=KRQP0HL4Fc/5LhcULHdwT87kEAiG3KbUQ+O9s61jDWg=;
        b=SXdZn2ZImu80xdETCea+8O+23QpimKZ4nZZn+APOaspdxRNg1+QGkgWd8YtxVhz/HH
         ujT9z0PRfGTE+q/JwMja+70y0RgbkjO4ozgHzwoaPC8xm81qF45gkA/Yva502t9yY/q+
         ZU8daYu7aIOKFqUDoRP2unOard8+3fsKmKGGXAcrPOO+/GrEo7L2/bxVOBI9May7kChD
         Qun6YLm9AdtuJPWAuROBmo29q5IQT59FqfqFwRf4988Ofip9S032cDB9HOeMk+7lOylP
         1qrynmMcfSPQMCHKBnwl/VmWzPHMsNPJDY9DcYGZGwzkbp3bJNI3SiyL/5IiHChA4M9z
         wAYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917953; x=1771522753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmDSu9rHdkQKCyukTIemQGDTasI1Oy6wKb2WDyCVFJM=;
        b=K/QQM+VGrUoxJiBLZrTobZf6pSS0BbZKmzWgDuDBRYEMMOu6xRoDybsEnVqltlzywq
         3s1CzxHfDRZ7kWF9+n7d2SFFMUw+dCn9WqdUK+5S1sDAbIgAx4YiTrr+Pk1rte/xD4hZ
         mfmKxPsX4EJlX+0jgkuDgN2qZWq5BFRCO+zSWhK1lkUbk+7gG6gXAxdotlpF7xUAEXsp
         0eAVA7ilfeY9zXR3Y71BDU8AWmudlq24yP+pcoVL6n5LJT8d6kH8tneuZtLsMWbkzKWq
         westECOujWxXnzUPr8wXSVNiG6z/X5x6EWJwXM1p5zaQ9QOuYCHLnhySdH69opb8WsW2
         uS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917953; x=1771522753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmDSu9rHdkQKCyukTIemQGDTasI1Oy6wKb2WDyCVFJM=;
        b=WkS1GZX2RHpmfStNGvJ+mGFzbSSjI0GfDE2aBaM1RkJDClLKoSKa6rcsv75pkViBKl
         CaC8jCa6Oc/OLLJj44ASr4ToA6tIMlDh1aV3blDfd8dHDYbhjehIrFim2nAFzodDzeD5
         eLphgITPU7Jwnv3GhcWOTGvINRkz5BKUx4X81CXzU0nnDn/C/Tn+gzJpmzKKmhOWR/d3
         medJkGqjCp9v1Yi0irKvqE4kb5H1xAfwaXmpAzlbP47YF9i2i1d6FIxOy1lxzonC5V6x
         Zvk3g3wSWfFClludGyLqyxGTJ/+7CV2jdgEmwoLe+aL9Rt27vrFHAJ3Ud3nZzaimDEmU
         bplg==
X-Forwarded-Encrypted: i=1; AJvYcCWDipjEo4hvaIn6EOPwgZB2RSlthwLOf1iFkKmYI1yHU4ILHOHN11glNgzZ9yQd5KQOAOZbqclm@vger.kernel.org
X-Gm-Message-State: AOJu0YwPW4XXiDFr4jagtbI8u76i/I3TLEJS2tobjYd1+3CWGSrUg9Bn
	UoZt5GWRvaYcTozJEfLS18Xdrm6lCwpbIGJ/xqVyviHD5OqIGVovxLE3R5+bRTNpNpDaunfxRf9
	zwRI8EBP8DBRM3xphAQ8HtaIrB5p/+NI=
X-Gm-Gg: AZuq6aLtOiW4qutObPt7rGByERhXUFykRZHlBvYz4VH2CCQt1u2MFsy6fif/hAkaiKR
	Hj1W+ljolnuydE5bKkCmvyJYLB+AkoO3VKlWVDkRjsloJTycYkGGay8c7V+fLC46cYw9luqkRNm
	NyHJOkFcsq5m2pSq+JahJYfK2aM6JYSt6/WHbxBS8CMIcNVeBCHPCjOzz1YG6gcB+0dQ22d9ZHW
	uA4fQqVbqrhhmGHmkyozSOCcL2UFl8kNs6J81GfHbITDz+wwQBur3tcEINIsbFxoy+ZiZZN98PE
	Jx4HHv/qHnGfdR4MBPmc8PDTLmteCOSVtgY0xSo=
X-Received: by 2002:a05:6000:4024:b0:436:1b1:6cbb with SMTP id
 ffacd0b85a97d-4378aa01106mr5591885f8f.7.1770917953341; Thu, 12 Feb 2026
 09:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-1-nphamcs@gmail.com> <CAKEwX=OvuVPJzQsSQm8F+zsRgJFnbMmW2JMJbGebp=U8+jMRYA@mail.gmail.com>
 <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org> <CAKEwX=Pww3ZNw=VGZBa46NhKuvefRM7wnVuZy0aADoCoE1KSzA@mail.gmail.com>
In-Reply-To: <CAKEwX=Pww3ZNw=VGZBa46NhKuvefRM7wnVuZy0aADoCoE1KSzA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Feb 2026 09:39:02 -0800
X-Gm-Features: AZwV_QinV0WPB7Xpdl--Xq3J6j8mlfT34orj9Pvsm2hWI8SWmVi_aDb838NayvE
Message-ID: <CAKEwX=Oqn5vZrYnURqwoNBhBmA5xU9jy5-5ti8vzFs2DHDaWYg@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, kasong@tencent.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	bhe@redhat.com, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, tglx@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, lenb@kernel.org, 
	Zi Yan <ziy@nvidia.com>, dev.jain@arm.com, lance.yang@linux.dev, 
	matthew.brost@intel.com, rakie.kim@sk.com, byungchul@sk.com, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, apopple@nvidia.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[get_maintainers.pl:server fail,sto.lore.kernel.org:server fail,mail.gmail.com:server fail];
	TAGGED_FROM(0.00)[bounces-13907-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com,suse.cz,suse.com,lwn.net,infradead.org,linux.alibaba.com,nvidia.com,sk.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[59];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,get_maintainers.pl:url]
X-Rspamd-Queue-Id: D5B28130004
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 9:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Feb 12, 2026 at 4:23=E2=80=AFAM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >>
> > Are you CCing all maintainers that get_maintainers.pl suggests you to c=
c?
> >
> > --
> > Cheers,
> >
> > David
>
> I hope so... did I miss someone? If so, my apologies - I manually add
> them one at a time to be completely honest. The list is huge...
>
> I'll probably use a script to convert that huge output next time into "--=
cc".
>

Ok let's try... this :) Probably should have done it from the start,
but better late than never...

Not sure who was missing from the first run - my apologies if I did
that.... I'll be more careful with huge cc list next time and just
scriptify it.

