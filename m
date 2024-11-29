Return-Path: <cgroups+bounces-5714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB39DC0EE
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 09:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FA42824F4
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF61684B0;
	Fri, 29 Nov 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWoHO7GC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BA15C13F
	for <cgroups@vger.kernel.org>; Fri, 29 Nov 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870722; cv=none; b=DLxrTVAJL8mK6ofeKPJAyhqrLxfBWIpVX0b6s04c30aWf7j5g437kPbaVVr+r4Y45DY8/8+cLhHwcva9GG9ivTNJUg5RCU+K0pFHN3HTgXZ7iCOP2xEeBs4F4ChJhZecY4e2fBftlN9ntgx0DQzEvQSc2BJuo9Xl5hd0vpFgS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870722; c=relaxed/simple;
	bh=usawajAMIv/TKzX/mVdfakUPPxK+NBwUIhH7uAqGE9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogLSFIWfNlBE5yX0By0ba+Rzlf7YZlGMm+ITvMSr9rTRvdl+bwTWYiwPmxGtv/QpM1fX1jFEQhSnd3Q6ToauT17Z4hh4AH9qnICDnEOboje8JZrMP3u9VxQeNjReBhpV76KgGNVJXthXex3dOm4/0VwBDqgSbFAxXi5I8+eEuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWoHO7GC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3823eaad37aso1710633f8f.0
        for <cgroups@vger.kernel.org>; Fri, 29 Nov 2024 00:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732870719; x=1733475519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiMRUUT2M7xVzatty0ZrzXrnlDpHODfPfP79MfeCsvw=;
        b=iWoHO7GCTe6m3o+lu/72RF4jX1bMDfuimwUTvfgD20INREmtNVwKuwz8AXtHfd8+z/
         escQU+D5rzBMXDoe/Ak+3cNG1sJ5rTa3Bfer6VKuAUcUoTP2nmshdrwQn8D0mCzvo1dN
         rKk2Dqoe3bs135RNAmuJ6J35CYSwW9xBLmZ/AHPv9Y4pDQ+pCWKjQREktJir1LcNB6Dw
         rlE9IzWCP4YLD8JJUJ8n+92ysozYdrVqoR799WTQErduVGSEtWsufLu9BvA43Yd6F3LO
         TdlrqTnGPddATZT662GwjdqPnC2Z6/qix0yD2K3erziuJO4iIL9QS1XoQgP7ed2SpmbL
         YK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870719; x=1733475519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiMRUUT2M7xVzatty0ZrzXrnlDpHODfPfP79MfeCsvw=;
        b=DQ+/7reyy4XS2vZJFC+WQS9B64h4wyC1Ul9axAFwghmzjnUtk80PgtOSNUnyxQ/H+q
         PdIjg0MB2iRfXTNLDbCsZHXWP0+l0lEEclLjTxXk/0j6vaSGoOZne/9P8cb9pvbUvRJC
         egnapc3Dma+1r/1SgJ8VS4hx51C7mbGzzJ28XSAk3AGkiXLn/h7PwlWC2bD67XJabetL
         Zfi5vYkhfDCAizm2mTSjY8YXmpcVBcYvyuhHaTBRvIj5QYgZ6LgY5B6Qqs1b1CzZ+OQT
         67xdckGNdbK0O4iNacXG4FH7FrEdQAcdVqvg6DH+PCdT7j04Bw7pNT9RDvJ5B4caq+4B
         JoQw==
X-Forwarded-Encrypted: i=1; AJvYcCXR7YVj2ar8r4UDeAW83+VZBNSH/kjfNA4obDpSJBOhBAKu4OY8PEuVt5xjf8EwKE9aDk7KT1wW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZLPjXjZ5M8Z9NwcCorrf1+ps53+uV3mB8H0YrjWhFayzFtZ6
	q+ZXCUuTnmV6ql5m4AxpRx3KYX1b0hCKUloCzVMT2RjmW3A0Fe6H3uWI5LZ8ZYvnWwG22afEkQ5
	vRd6XpnYPSTZcbNnFQdnvPd8g3ae83OsR3JUR
X-Gm-Gg: ASbGncv/ZS7BGyQz13RicGNRrcXxeF1GcphYlDlU+83HBhn9m9Z7lTuwdeorUA5gUSQ
	DW61rfUvshf2ScxNAgHgyqXrYpbSmAJVKziW2aEvC/VEPPpluWJX2MosNRWo0Ig==
X-Google-Smtp-Source: AGHT+IHZfE+MvE59g3GUbb6K8cSnEsXzMx7JEog6LGr2L2lWRogqLF0km2dm7xM7vKZZ+7cUaT+QbeJVrgf31YLfu3s=
X-Received: by 2002:a05:6000:4008:b0:385:ca48:2852 with SMTP id
 ffacd0b85a97d-385cbd7c28dmr5175022f8f.13.1732870719463; Fri, 29 Nov 2024
 00:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com> <Z0j3Nfm_EXiGPObq@casper.infradead.org>
In-Reply-To: <Z0j3Nfm_EXiGPObq@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 29 Nov 2024 09:58:27 +0100
Message-ID: <CAH5fLgg00x1SaV-nmPtvRw_26sZbQxW3B0UWSr1suAmhybxc_Q@mail.gmail.com>
Subject: Re: [PATCH] list_lru: expand list_lru_add() docs with info about sublists
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 12:05=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Nov 28, 2024 at 12:12:11PM +0000, Alice Ryhl wrote:
> > - * Return: true if the list was updated, false otherwise
> > + * Return value: true if the item was added, false otherwise
>
> This is an incorrect change.  The section is always called 'Return', not
> 'Return value'; see Documentation/doc-guide/kernel-doc.rst.  And I
> think it was fine to say "list was updated" rather than "item was
> added".  They're basically synonyms.
>
> > - * Return value: true if the list was updated, false otherwise
> > + * Return value: true if the item was added, false otherwise
>
> Ditto (and other similar changes)

Oh I had not noticed the "Return"/"Return value" change. It must be a
copy-paste artifact from list_lru_del_obj() which already uses "Return
value". Would you like me to change that one to 'Return'?

As for the other rewording, I thought it was slightly more
unambiguous, but don't feel strongly about it.

Alice

