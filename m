Return-Path: <cgroups+bounces-468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A87EFD6F
	for <lists+cgroups@lfdr.de>; Sat, 18 Nov 2023 04:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893BB2813A7
	for <lists+cgroups@lfdr.de>; Sat, 18 Nov 2023 03:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C025692;
	Sat, 18 Nov 2023 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOaCSrb8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8246D7A
	for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 19:33:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc1e1e74beso23658185ad.1
        for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700278435; x=1700883235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dF27M13Q5uIXKU9SuRFjuyiZuatrs8pB1vllLX+2P7M=;
        b=FOaCSrb8llwD112mZusnkMkAgqb83MPZihaaO3g6rzb+kSoU8PpZxvEoWVw7q1OTU6
         /g6WJJ5L7cb12/gacJfSb9lN49TnLWuJWnfzGHIKGYS/wRZH4oziKeEEYXciz4kiveDV
         UdvwtQAVLQpz6jTn50ujtowZiKtuwbG0g8YRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278435; x=1700883235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF27M13Q5uIXKU9SuRFjuyiZuatrs8pB1vllLX+2P7M=;
        b=WLxXompz0J+N5HQQYsh6Y5S8b858B+tkaiqZdyRNhdgYjrKq0qJsWcdRuV8fqdClI/
         vyYHa7JPyxcIFR/aKhjtD+yw1CjinwKImUu7REouWZkKDmZBgpaf99/JRM/QJHtKVgpv
         Fk1AAVLPt/oA63RVxHzD/5rxKW80ZH8eElIcEiwgm7tTWnLwKraNryhYGc3Ur/qTDifF
         5uy1N18nXvl5DO1vPm9ZQwKDCeHGHITkM/pce1QxN8rVcAxWGikDL5o1TMvtDj+WCyIa
         fa/pSJp2VujSWYl2od7IodtmO3UlgLmIV5EyqsXjJw0rtFg++zAVM3TfT9uCtJOjf4DW
         plVQ==
X-Gm-Message-State: AOJu0YyvqDOed/zqqSLsoX7fq6XUTp+rvJ74bFwP6fBeAvaLP1rlFM1m
	6IVTEkg9ID0tkU4k6Z4g/C6KmZR/+jd6FK1FwTNWlQ==
X-Google-Smtp-Source: AGHT+IFiVXVkJA1L9nXFiQfIL0/MD9bacMDG55+9sSwrswN9Mzf/813jB6DUKoAwLgRaC0LvRmDoEQ==
X-Received: by 2002:a17:902:cec8:b0:1ce:5b21:5c2e with SMTP id d8-20020a170902cec800b001ce5b215c2emr1703535plg.17.1700278435110;
        Fri, 17 Nov 2023 19:33:55 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001c8836a3795sm2052356plw.271.2023.11.17.19.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:33:54 -0800 (PST)
Date: Fri, 17 Nov 2023 19:33:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] kernfs: Convert kernfs_path_from_node_locked() from
 strlcpy() to strscpy()
Message-ID: <202311171933.5792E9FFFE@keescook>
References: <20231116191718.work.246-kees@kernel.org>
 <20231116192127.1558276-3-keescook@chromium.org>
 <20231117084757.150724ed@rorschach.local.home>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117084757.150724ed@rorschach.local.home>

On Fri, Nov 17, 2023 at 08:47:57AM -0500, Steven Rostedt wrote:
> >  kernel/trace/trace_uprobe.c |  2 +-
> 
> trace_uprobe.c seems out of scope for this patch.

Oops. Yes, that's in the wrong patch. I will respin the series...

-- 
Kees Cook

