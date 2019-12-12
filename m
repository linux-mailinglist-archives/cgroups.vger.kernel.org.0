Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768C811D23E
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2019 17:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfLLQ11 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Dec 2019 11:27:27 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:35323 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729839AbfLLQ11 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Dec 2019 11:27:27 -0500
Received: by mail-io1-f51.google.com with SMTP id v18so3452837iol.2
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2019 08:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L2CjDVtbtRmSS9p/ZMC2e8zHEfBbFA8EoUfM5bDUuwA=;
        b=T6xkncOLY8LZ+5xON4nDUfI/fzvqKg69ZBb0XfMIjL9EDlMcrpyTzYV3jPEUECIu7e
         /6VePkJbfJ02IxgtjhVi7zhODL3RzicRz8RUUxTG9FMA0/+l2gwHg1lkXa+9Xz19lG5P
         RIW0WHds+gFZXVLHMoYOU2aVxFfugcJGN8+IRth7RzCBvBQvkKfr6RZdZFv3XFAGcEv8
         0jvtGdkjF2LOv6J2oK0OhlmGZ96TS3op6ZjE2hRprquRNtnWc1QVP2D5xZElq0NP++dH
         FdY9uKj1DamP/Cer06/nmE/izvRIUNoXzSdvxib0JD4MDAk3nsjsBw7M9wgtvidm7gjA
         sI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2CjDVtbtRmSS9p/ZMC2e8zHEfBbFA8EoUfM5bDUuwA=;
        b=CeqLZU3U1dGqnlLtrUJ4zQjeAXLsFi+6xrveGvIpTXjIkfC8yiobNuL4rM9g+sa5/j
         j/CwLxOgtrv8QZ78I/zIPFfmtb2sfYxaa9pf1/m6dIXZf1umL8Sv1rct0Gp9k+mYJ3WP
         EPvH4hj695RbKQNPumi5N41zPS0Xe6D9RnMvbv4CIXsGRM5cDkeuEWq/ReAMegB6vJrd
         1KtheyL6h4rKzheoUvJMUOCVDqfJaFfW7dZYr1znmB8q8gQmIqr5bCxLSGlRNdseMtd5
         Zw4te89LRHBdxNYz7Wacj1v6Y4fyYX6keUtrxdAyJUNNg2Dg2la0M56FCfWwUytbLH4+
         OLVg==
X-Gm-Message-State: APjAAAV8Ro+5FOdtcfPFR3zyrt38Og5+QqIxCmL2hFk0GezWRtGpoexX
        D4IQt7Y7KhGj1SnQ3Zsa1VZWZQ==
X-Google-Smtp-Source: APXvYqxoJV4anqq+qDAdhKogptjDsSD2zTMOztmiodrLP2ZIGIITw+1PsHhlCWyUyDRKNb2x5gMkZA==
X-Received: by 2002:a05:6638:304:: with SMTP id w4mr8644279jap.81.1576168046416;
        Thu, 12 Dec 2019 08:27:26 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k7sm1836770ilg.49.2019.12.12.08.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 08:27:25 -0800 (PST)
Subject: Re: [PATCH v2] blk-cgroup: remove blkcg_drain_queue
To:     jgq516@gmail.com, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20191212155200.13403-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f8133d5-fb25-a588-3cd8-b3b6dbfae4c8@kernel.dk>
Date:   Thu, 12 Dec 2019 09:27:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212155200.13403-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/12/19 8:52 AM, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Since blk_drain_queue had already been removed, so this function
> is not needed anymore.

Applied, thanks.

-- 
Jens Axboe

