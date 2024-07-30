Return-Path: <cgroups+bounces-4009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB0942136
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 22:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28D31C23E3A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 20:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245318CBE0;
	Tue, 30 Jul 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HYfr7WYN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6418B479
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369741; cv=none; b=S4D/BOCR8jb0EKQwzvXAiFa7VX5tsMGtSkusfAxMIU8wD2nWLtEpBdGwpcmyqSLCi7I6yep1MUEiwJ20ESTjtfS5+7+VEDVYF6GfqyQ2OR0iWg5Vg9hHMcFAujP5+g6mepItYG0f/YuPNVPU6ioK4p9Jh5v1W0iIhSk1SUgz/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369741; c=relaxed/simple;
	bh=g3+niUA0xpO8QTVJVcFoGPOfgBAUBJotciNokbhnVRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWqLqLYuGdjgFiVw0olemt2uF7us4p44nS7WQPAVLcVPLHBKAoJ/DC/FGqE1cmV7lX2S0hxqs5MZ3wn9pJZ7eAK4QjOjzb9JzDHPeErGcCJgyJMN37eELMY9skbT+I/q5FfPzAMtAZaaLjlccoCFEd3UISJEaD9jfSNz8G9X6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HYfr7WYN; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66acac24443so37794857b3.1
        for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722369739; x=1722974539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gM+dZs0nyyuKls7rKhwHwLihUP2+Vq1HQ7Y/s6r/BU=;
        b=HYfr7WYNGarWyLNF69C3lXcrXW/5WVaA+PPajlEQ0z7AieDIHFfyOwQO/a7k8Fkofh
         rso4vj3PmFroT1anQVjb4V7pm09jvAv0JMJwo5DcxD8nPYDe2gmu0eaTXLJqzTUDkaxj
         voWPaWN3QVYgGAM7jG3XAkcFtnvSxBocGSwZnC/9h1a8cdyt73QRareaVtEG9jXk5/y/
         IcUBny7mNWZb4oLjnriCRSBwJvEfU5PJN67SFqyTdLgKBELgdmXdtLLe8MfInSQIRUH+
         +7TVrEwPVVscO6OA0cd595IFLAY9ov5bc8Oqi/p+UlEAg5z1gYuJRbShFrkm9XQxKpLg
         YAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369739; x=1722974539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gM+dZs0nyyuKls7rKhwHwLihUP2+Vq1HQ7Y/s6r/BU=;
        b=agW5pvbZLeqHLQE2+9FoFosfUxz9vj+xOgRQFNRLLvT+zsaOKuv+Vql+0YG3A/PoUw
         UYlv1AQduEaX5T4Kenm+F8739PyrgBOzG81l4N+wxYhMrW4GlWwkKiIClvCpCFlg8JpE
         pURLMpQ7q6yzx19of8x25n4WXRy3Bga0qTfBLz557Z+hkPxze5mduvI4qd65hBnzN+En
         x90Tt6rDiIOZ8OJdpyzXEOi4jHuSbz4HtRphql8dS6z0jMhWxU9iiMyWMRU9FH6molA0
         xaM9zkEWQLLzPLyxgtOdsoCyWhADbiwzsCPQfbaaBmomxJO1azZa/SsgOnOBqeAUbct7
         ZOKA==
X-Forwarded-Encrypted: i=1; AJvYcCVa1OhXS07BXUnS3G9yfD2i9Tfss+4DceKvEBGanMkf0ZJQHu3r3j01xkMM94PJa7nB6lDHo84//WBde/GDe+7sj3zahe9K6w==
X-Gm-Message-State: AOJu0Yynxp/Hn04PfR5ourVRYMqF8/RyxDQCZhXDfkwtoApA4XetPVu9
	B7fBRH3pV0fj5hIwDfwMErSqUGHB9Bp6ukASOfyMWWTtiFfzkqp/d32tNDuugcyFN3jXQP7NvQ8
	9
X-Google-Smtp-Source: AGHT+IHLhGc5P0Jkbn9GYe5+/TwFVFrZFTBX39bypM6SoAI4XaUY0Lf3nB+cU1gq/JuQtI04+biYKQ==
X-Received: by 2002:a25:d6c7:0:b0:e0b:28fa:75da with SMTP id 3f1490d57ef6-e0b54402a04mr11264617276.1.1722369739201;
        Tue, 30 Jul 2024 13:02:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a93fa51sm2532245276.54.2024.07.30.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:02:18 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:02:18 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240730200218.GC3830393@perftesting>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>

On Tue, Jul 30, 2024 at 06:09:27AM +0100, Al Viro wrote:
> 		Background
> 		==========
> 

<snip>

I reviewed the best I could, validated all the error paths, checked the
resulting code.  There's a few places where you've left // style comments that I
assume you'll clean up before you are done.  I had two questions, one about
formatting and one about a changelog.  I don't think either of those are going
to affect my review if you change them, so you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef

