Return-Path: <cgroups+bounces-5625-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C089D19CB
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 21:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E021F21D6B
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 20:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E196F1E764B;
	Mon, 18 Nov 2024 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="FUJHfMNK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66A1E571A
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962571; cv=none; b=XrmRbyURLcROkIHqFAhkBUpDHySLcONAPqCb6AhL8qi2+9gmZIEIsW/vkWbC1JGpUEtILESlgYZWR1z7HUA5DLwFyhUzbecPMvWz0YcaTgdmLiRBjoYtOfM6yA6ZLefcuFsKUqhmipze8Y8gc0NFXAtnYveeDNNIRXfcZ2v9zSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962571; c=relaxed/simple;
	bh=dxabNGakL9NrepH5do7y1wnleH+dNche06QzIaELHEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUNVDumcVyxnkPQxfrv0539B+nzuQZGGjQ5tLJdQ6Nz3frJ6cRYO77DK2pmnMXeWitwY5MfpGQo7j3H4aBLiJ7Ks8HEq+1qOeP9+jFMXTCVb42mTFsEhz9Np1kqddYceOPXEYDhZsMyHKo0+cUVBZDr4fegF9vXtcKHX1kxIc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=FUJHfMNK; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ee9e209bb6so87353eaf.0
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731962569; x=1732567369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Az3Sp8d9covPjAGoeraghsVludZNEdQZrTadq9s3zg4=;
        b=FUJHfMNKRviJrGBdZmSorm9HK+yxWtkfXbWyRmPRefXg96VxXIpgXCvg99Dc0fDMFV
         WtUANSnAESrftl1nHDR8rfAMRXefAT6MLW+2v1wo5bU0F3O63e0MquGb1VAFyRK3JFZ1
         tXQRR32/lhFpiRQQ9c5wJSsWEa8r7Xyg47PaRRm2dajgn4sje9XjLkGZtIWLEsDgwnkv
         5EkDQMI0vW+MmYojcBo39EC3uZNx1x5AKrQts//GeRadpZpE4+Fejt5/46oLXVKI8UuF
         uncYQYieqpP2hhpWXFLIoR48ICLuf7IGkuRHC8CcqHDYsM/emmmQ81nuOZoGDW2Q13FM
         LT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731962569; x=1732567369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Az3Sp8d9covPjAGoeraghsVludZNEdQZrTadq9s3zg4=;
        b=DInkiArmlAStDlcrdUE6NXluKnEx3KdIZ0vud5UvXMCCBpr2xsM2o8mrMW1ajCkn9y
         xg3mTJVs5Jm4JXNcc5g7GQ+SOuRu+0cSkD45+dIYftM0nIJkyGC2ZNiua9jqsXBZRhul
         k9FIF3O85apzl9J5f1yMjB/y7wZQOwFqGFJBAdM6h2F+cA+aU4p3m3e4Mr763X3dfnCE
         I9MTfMhXFiF7DL6j5vUn1Vi2FFvqrQ+3h5pVwsU5AKdiM3I7JQNne9+Ut7Q9vMAEyBjy
         9wnEbFuHY+kBKJX5kcqfKJQmCO2zMe64fFEE+MSzul1hFBp8q65o0CfwgMF5lRfP6cZM
         1yLw==
X-Forwarded-Encrypted: i=1; AJvYcCUqj3FCyjR2J5pw9MmWbnYz6qANQ8Z5DqQTH0OPdu6zN7NW9L7am2XtO+UgZQUxvdKjaTAqkiz0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TIhrVIKv0XdXZhiGqKxy4uKcIjvjS22Xjbjuqs7h/OIWh25C
	skNfVfkHHbOYVMT8r7AnZjLyrf2ksvPNZKTHfxL7E//nLbwpwvl5hOTZ9ETX37/w/lguT9dwBtb
	tsCE1gDOzHDxyj0NjgObZTkYvwzyZvu6flCCghA==
X-Google-Smtp-Source: AGHT+IHttxr2eFNSFhV8PpJus1DCBKmx1o7nfN6x9M9fk44cvRJr2moQ/A4XKlnUEVw6YKcIvYheu82B5igacrHaq1Y=
X-Received: by 2002:a05:6358:170b:b0:1c5:e2ea:8992 with SMTP id
 e5c5f4694b2df-1c6cd22c1e4mr505681155d.11.1731962569411; Mon, 18 Nov 2024
 12:42:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-3-pasha.tatashin@soleen.com> <ZzrjYtoC3G0Yl8pM@infradead.org>
In-Reply-To: <ZzrjYtoC3G0Yl8pM@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 15:42:12 -0500
Message-ID: <CA+CK2bDp9A+ZzEwm60vDW8m_3U7u3FM0iUdM1N59VjdwM4_j5g@mail.gmail.com>
Subject: Re: [RFCv1 2/6] pagewalk: Add a page table walker for init_mm page table
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com, 
	schalla@marvell.com, david@redhat.com, willy@infradead.org, osalvador@suse.de, 
	usama.anjum@collabora.com, andrii@kernel.org, ryan.roberts@arm.com, 
	peterx@redhat.com, oleg@redhat.com, tandersen@netflix.com, 
	rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 1:49=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Nov 16, 2024 at 05:59:18PM +0000, Pasha Tatashin wrote:
> >       } while (start =3D next, start < end);
> >       return err;
> >  }
> > +EXPORT_SYMBOL_GPL(walk_page_range);
>
> Umm, no.  We really should not expose all these page table detail
> to modules.
>
> > +EXPORT_SYMBOL_GPL(walk_page_range_kernel);
>
> Even more so here.

I will remove these exports in the next version, as I am going to
convert Page Detective to be part of core mm instead of misc device.

Thanks,
Pasha

