Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF14179582
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgCDQjZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 11:39:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36446 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgCDQjZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 11:39:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so1841572qto.3;
        Wed, 04 Mar 2020 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q41tiblFE54JAr5vC6itpkRF9zh1xfIn6lFKVFQ8hPE=;
        b=jgpGs27cukeF4u6jimr8YXOzqdUGDnBvlaasW3APkR/3ylULaFPdFft2i7tjdKMoug
         K6v0nKjw50uodI+joOgqp920D8ANct5b0St90yLhBMiPOSfBrwMO9U+phnqmFMuzglpg
         884HqvfXDMjsXb50UTyzG34uXIQ9eJS65e+7fP2KA5Irn35utXNDG9ekv2KX/eIEX7gQ
         a04loJYII0g/hCdWfBKxsGrEygu86tSmz6TSKkuydhhucErZcw0NdksFDxA1hMOXyQ6E
         deVaNCkiC1C/Oli/G4zom94cs+cxd+ivOZIY2MGkg3jUkAjZQ8LR7OXBXHkOao9nR4y8
         pTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Q41tiblFE54JAr5vC6itpkRF9zh1xfIn6lFKVFQ8hPE=;
        b=YVf2OU0VHl4IFnpEn9Zw6W8eTH4JdWYPlkLXKXpAZxTbt4I5wAIjZEYv0Qvhn0aAaP
         gJ+EqpXZbmC2u/3AtY71PQsb1PbG2w+H/n+g9xRKypCnUSKjJ3dxY0UwWl3OKvVnXBZx
         wdvVze1wGjY/b5sNQTKPhz/zTO1Vg9uVgav/UZLMueYy0+wEJhtPQeXOglSh6VWCd7hH
         KcK91Yp6HQSZwx5ihtbdl8cGQ9YHcMyg2gUJi1x2T17PvXrM9R+BTH6mb/mn+ZKZPe6d
         vg6za9tqhjC6/nC7HTMJ5mpV9NQtNPxQbWdlyKczrRWvAYnCJF3+OVnw7B1VKOyImXw6
         ckmg==
X-Gm-Message-State: ANhLgQ3QakZem5zRdZWgIlNe6+tUbrDNxkXcHB+tTFsfdc+EtFFYvUcW
        on5ZtWQ3Rsdz0vT01XjQQdS1j7mnC/A=
X-Google-Smtp-Source: ADFU+vv6B6uHErWbe6EYCVm4UjJigrIY9oE2hn3aI/w5O4AOCgONkkVZPGldpOis+jjjZWdPotLDnA==
X-Received: by 2002:ac8:e45:: with SMTP id j5mr117129qti.215.1583339964277;
        Wed, 04 Mar 2020 08:39:24 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id d1sm1903151qtn.78.2020.03.04.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:39:23 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:39:22 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] kernfs: Add option to enable user xattrs
Message-ID: <20200304163922.GG189690@mtj.thefacebook.com>
References: <C11FYO0Q9WJU.2MLRRFOQ3E878@dlxu-fedora-R90QNFJV>
 <C11GC2SN5D18.2S00I3KONE9ZE@dlxu-fedora-R90QNFJV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C11GC2SN5D18.2S00I3KONE9ZE@dlxu-fedora-R90QNFJV>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Mar 03, 2020 at 11:37:28AM -0800, Daniel Xu wrote:
> It looks like in fs/xattr.c:setxattr, there is already:
> 
>     ...
>     if (size) {
>         if (size > XATTR_SIZE_MAX)
>             return -E2BIG;
>     ...
> 
> where XATTR_SIZE_MAX is defined as 64k. Do you want it even smaller?

Oh, I missed that. Order 5 allocations can still be on the big side
tho. Ideally, something like the following?

* Total number of bytes limit as the primary limit so that we can say
  that for a given cgroup user xattrs don't consume more than X bytes.
  We can pick an arbitrary number which is large enough for most use
  cases but not too big. e.g. 128k or whatever.

* Total number of xattrs limit. Again, some arbitrary not too low, not
  too high limit.

* Switch to kvmalloc() for attr allocation so that we don't have to
  worry about high order allocations.

Thanks.

-- 
tejun
