Return-Path: <cgroups+bounces-6184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666E4A13627
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 10:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B60447A12FE
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6721D7E33;
	Thu, 16 Jan 2025 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="anBtU/YP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FA1A08BC
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018369; cv=none; b=W+xTaTuzfSLlgm7AgXG0rJNlu4eD32grmor148y5ovGRQHT446h0Q0QgYf4mwNMOHDlkWYg7r1fdVwKaLefoF/XzGVXOMzAShJawzRMH6jXM00BF1XeSF435KpYWYSmPZ1ABQ2egaLNnXZxhILckyWd9zybS+pkTEgB+bmWxw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018369; c=relaxed/simple;
	bh=Fyty0rNeX2yiWWT1aURj/tfcYLq5hJIr6iNivV6v43M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU8Uk2+5EToaxIH4QHS8Zc2m5M+LZRdQwhk8mE/2XOyeEW9VMQu4BwLKs759l0vElVafWjLgVybSTvrzFsRtBdr3FQxxK07dBacbzLslrV3gt9CLGV1fUdHMlF3PAAVsPjx/aqGevB64g27u1WVJyv5AaMgIi8EHPNPkjZgUC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=anBtU/YP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e06af753so349574f8f.2
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 01:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737018366; x=1737623166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvLoYGW797Wwa5tA/CyXEnf4NFivauTHwpj75TV5TX0=;
        b=anBtU/YP8pfr6kOk8M0hlr7hEsyFLMxMsGe07HbmXsIx8RLACgcli+rcrowD1Po5Z4
         o7hh65PvZsYE0/75j6i+NITW8aMcpeQQvv+xZmBL1bMrcH0UEdwC3bgZVrsdb9ZufBm+
         imTXTUKsOTM9Cnwyei90kzf8lWJd7P+ArGMTJUtamf+M+9/qea0TLAvGDSaRZiOPaK1h
         u3bQH3RnsErw7CxbLl/FdJRP4b+C1kEMltn4n97xbNow+l/4jqy7GIruNwZfjDbnhQmp
         c0VzVj1kDkY5y8qLmj/YOILsCUsmT5xfp//p/2sF+asILOIpb66HgutB38pMW+JcThRk
         pZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737018366; x=1737623166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvLoYGW797Wwa5tA/CyXEnf4NFivauTHwpj75TV5TX0=;
        b=mxmlDbsFoQle1KQ3YrVMjxtXTT7LDKrstJ7feeIwLWk3U0nBt+JPgq90Rwgd8QTFsT
         xRRTq63tGQ0W3Npn6LoL1jb2ih86BS1L4G6VzfpND62jhN6YAZWRYh+9ttrlfunheGO4
         5motbesy1+k8L9W439MYhs+fLL4EyJH6gT5YQt+0jHupFAMMUs22fbJ0dDoWEU60Zkum
         tmPFpqRxZlxc8mD6CFDfIt4jjAPNZtGXfgv9h+BvaubbbwRR8BRcAvQsqppFprOcPjSq
         KVtoaHR1XAI4kypBhRzcY9WObmgyWtXjAUM955f+sHPuNVdtCmVmo2Tz+xAOV7rLj1HR
         EcUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsnCT8H36eMT/JvowVgC2LwxZO1+4uRP1/cWknJvfbxxWqXsgaaEIVGDl05etfe7LYEWJYO9XV@vger.kernel.org
X-Gm-Message-State: AOJu0YxHs9crmfXc27QOQ/wP/h47G9gUPuqF6l49DN7b4Wh8c8qi7dMT
	UeJHjbqmKsM2wnXG9hhUSfRTicslG6jZygh1DndquZFEo/lbyVFLN7gzdEHzAFk=
X-Gm-Gg: ASbGncsEm3x78LQcUNVYrdTk4P+lK2lpfpuPsNXwHlJXJuis/X77VhMfijPKWuxXYFc
	72htSa3jKbHJqwyJqyuahy8dRCtHDrggSBlD2sMP4iq3cHgTHhwBgMCb28675e9kkYmAh+ABhi0
	RduUaJrIt1JJxNJiKO4xZlZcV0bUyU5aFctrq5P3Ddfc+fbl0zDxFgkzAc9ZwoBYNDkuB41xIWw
	nCILTY4+qX3qywkCkzA6KxHh8R114PeP6q+6oc6Z9TrUwpwiDqGaFBp/BpTvFp9+y6Nrg==
X-Google-Smtp-Source: AGHT+IEZEzn28CIcCG4IS7Ndr+zHZ02erH6CBGKsMWizQ+Tszr6rCV5A6NnVL5PjMhYeMeFv5lQt7Q==
X-Received: by 2002:a05:6000:4011:b0:385:f47b:1501 with SMTP id ffacd0b85a97d-38a87312d58mr26734400f8f.32.1737018365807;
        Thu, 16 Jan 2025 01:06:05 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74ac5f9sm51057375e9.11.2025.01.16.01.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 01:06:05 -0800 (PST)
Date: Thu, 16 Jan 2025 10:06:04 +0100
From: Michal Hocko <mhocko@suse.com>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>,
	Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
	cgroups@vger.kernel.org
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
Message-ID: <Z4jL_GzJ98S_VYa3@tiehlicka>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik>
 <20250115225920.GA669149@pevik>
 <Z4i6-WZ73FgOjvtq@tiehlicka>
 <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>

On Thu 16-01-25 13:37:14, Harshvardhan Jha wrote:
> Hello Michal
> On 16/01/25 1:23 PM, Michal Hocko wrote:
> > Hi,
> >
> > On Wed 15-01-25 23:59:20, Petr Vorel wrote:
> >> Hi Harshvardhan,
> >>
> >> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]
> > It is hard to decypher the output and nail down actual failure. Could
> > somebody do a TL;DR summary of the failure, since when it happens, is it
> > really v1 specific?
> 
> The test ltp_memcg_stat_rss is indeed cgroup v1 specific.

What does this test case aims to test?

-- 
Michal Hocko
SUSE Labs

