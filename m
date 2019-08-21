Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E4497F6F
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2019 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfHUPxd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Aug 2019 11:53:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38565 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHUPxc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Aug 2019 11:53:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id u190so2259977qkh.5
        for <cgroups@vger.kernel.org>; Wed, 21 Aug 2019 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N04aZbraHstGtd2N4jzbwtTQL7Y7JEPWx+OCV6a2CW8=;
        b=c3AzYgoGaZ0HmJzoIhU1rx9tKz7WYX4jimmIHXOb/EyLjqpCZQcpHgm0WRvMmVGUHP
         iruyXAOU6DYqZyhuBNf8CbX/fqXgVW2scIxcTAbKpWL6obFC2M+dQdadsneSVeKntf7+
         Ub6rz6PLe9tWfrMnboijw7AI4DWdzuO7d7d5CcSBxGXu4tFAwStboAAyvjr0PZ3JL06a
         +3khlkBsWIu99cmCSKfEPToUFzv3d2Dxwi3syp4i7YOrZ7ywMkEd/gZQClpr4dOZ9bYE
         SGfNvsP9dkSKasjCrAmvFNPXXknQWaC8Iay6YUIDdD3SD9kOGYrtj1HsYnRzyX7cB95g
         xfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N04aZbraHstGtd2N4jzbwtTQL7Y7JEPWx+OCV6a2CW8=;
        b=BeRSWe7Vqr1zSO1/ChRs4AFHIWJClPRch3Jt1q6ptCHlpdwyL0HBsf44A7r8g+gKLm
         JAustBau1+lnPcK/ICoX5cljbqGalZVE7JrNr7zGQw8afhyUpTbb+kXqYKmBMas3KbRE
         cup+8oLfTCcCeh7PRVZQA9CEHtGw2B0BL/nicqPg7J0g8PlAu4tfylgiBsVkIPtkRlV1
         YD73+1NtdI2RprY6WPQQ3K7+55pkQ4DzcGqbQ/hlpacRM3dAcP9Eol5jXm2PvorP0HKQ
         bR8ZKyaLc5oDt0wkc+MVSITJXaYXOjpR4BVC6hMEDcpq/Y/PjTBcvCl409cMwwypwsCT
         cl9Q==
X-Gm-Message-State: APjAAAWT++4eyMa1v8wnL2vhPz20QkSh/rymTEcEx6utQzufbyDKlpUm
        c5qYX923TuMvvXjmOHNMDxg=
X-Google-Smtp-Source: APXvYqx9z91axdIAsnfZc9fvoqJXgycXZVxWwdxdGi1TfuZ/yy7FRRh07DSzCtI0gQ7lmZVYlkIdDQ==
X-Received: by 2002:a05:620a:132e:: with SMTP id p14mr31993117qkj.498.1566402811531;
        Wed, 21 Aug 2019 08:53:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:1f05])
        by smtp.gmail.com with ESMTPSA id q9sm10580843qtj.48.2019.08.21.08.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:53:30 -0700 (PDT)
Date:   Wed, 21 Aug 2019 08:53:29 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, tglx@linutronix.de
Subject: Re: [PATCH 1/4] cgroup: Remove ->css_rstat_flush()
Message-ID: <20190821155329.GJ2263813@devbig004.ftw2.facebook.com>
References: <20190816111817.834-1-bigeasy@linutronix.de>
 <20190816111817.834-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816111817.834-2-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 16, 2019 at 01:18:14PM +0200, Sebastian Andrzej Siewior wrote:
> I was looking at the lifetime of the the ->css_rstat_flush() to see if
> cgroup_rstat_cpu_lock should remain a raw_spinlock_t. I didn't find any
> users and is unused since it was introduced in commit
>   8f53470bab042 ("cgroup: Add cgroup_subsys->css_rstat_flush()")
> 
> Remove the css_rstat_flush callback because it has no users.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Yeah, I'd rather keep it.  The patch which used this didn't get merged
but the use case is valid and it will likely be used for different
cases.

Thanks.

-- 
tejun
