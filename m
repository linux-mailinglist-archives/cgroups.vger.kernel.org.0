Return-Path: <cgroups+bounces-992-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D721781C279
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 01:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7714D1F24F5D
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 00:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F3A23;
	Fri, 22 Dec 2023 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewXLrxBJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09476623;
	Fri, 22 Dec 2023 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35d725ac060so5312945ab.2;
        Thu, 21 Dec 2023 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703206689; x=1703811489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNBZw8far6r+uQKfW3GLV97maqwcZ2n3sxfjJZfkPLE=;
        b=ewXLrxBJe64EggFb2lh/FpHnYZiOLJaWy8cPxCTeroCHKZbrtQaCWRYGGd38XEUXLB
         NoSU3pKnGgkDFpMQmZdWaZOz7MO5AW2OjBbRRhUtnf/9ysdTMxLwpUX+fYbirrDJWs6R
         q+Cc2JL7FbZxsL8JyqDNeh0UQl//J1+tH8S8t2Y4oytY+pubLhidMihOCnvKv9rjA7mg
         0l7MLunuamQWUFvhvOPOX42HZefhk8a/Nf3jrbpAwCK7ZZIcEfPfVyxWNzxiu1kb2MKQ
         y69xZ1M6dw2Ox9u+9tW5cXVBH09zDg2prA0V/amYanY2xoytrevZaSxG+++k6xgmIRVX
         nFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206689; x=1703811489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNBZw8far6r+uQKfW3GLV97maqwcZ2n3sxfjJZfkPLE=;
        b=Mv6LHBOAtZdfYPDceOnOKh2y/Snkmr2zGIEiaEBVQiqi89b4zPyb8kGcs6e+tKfG/S
         zDtjhjwOiIrw8aDEupk834LcCrm30DHh49T+BIdX/xZpbeqMEvOo85BaR2SVAVnytEMk
         sgiTIywtK+2LMkkOO+sl2zszWsIgX+sdHRltaxJVspdVZlnI0iwDIfhYL8mvRrBW2Xlj
         gEGdz/TKmoOxX9KBas5OIq6pCKUS/qJ+XuUMvL7HRLRmdwV88bE4VN8HFb98d5v7iVCl
         fWrP16jkb1rSmkOz92hb+PSl4mP+/xj9YpWmeeN+K5E+NegR4TiZRMbmjWlJNhu0+B/a
         qQKA==
X-Gm-Message-State: AOJu0YxdMfPj7AqOPQuGYYH7/ygtUuw9JoO4fCy5yuOEeHbqe162JDJt
	nLrEAJP48b7GqNZsOr09huU=
X-Google-Smtp-Source: AGHT+IH7UuQV6Jl8jSnT1D/fJz/HLpOeyjg4k6dO2l3wELYOvHTeClLCWM2E6xYCr2MyV2hYzDJuHw==
X-Received: by 2002:a05:6e02:20e5:b0:35f:b441:5c76 with SMTP id q5-20020a056e0220e500b0035fb4415c76mr588132ilv.17.1703206688883;
        Thu, 21 Dec 2023 16:58:08 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id j18-20020a63ec12000000b005c19c586cb7sm2162844pgh.33.2023.12.21.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 16:58:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 09:58:04 +0900
From: Tejun Heo <tj@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/3] kernfs: Convert kernfs_walk_ns() from strlcpy()
 to strscpy()
Message-ID: <ZYTfHH5078rtOui1@mtj.duckdns.org>
References: <20231212211606.make.155-kees@kernel.org>
 <20231212211741.164376-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212211741.164376-1-keescook@chromium.org>

On Tue, Dec 12, 2023 at 01:17:38PM -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> Link: https://lore.kernel.org/r/20231116192127.1558276-1-keescook@chromium.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

