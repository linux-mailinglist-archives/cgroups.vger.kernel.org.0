Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8FCF381D
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 20:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfKGTIY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 14:08:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46207 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbfKGTIV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 14:08:21 -0500
Received: by mail-io1-f65.google.com with SMTP id c6so3485243ioo.13
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2019 11:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6tc+3dFnObbCsZTOmcaVyw6tfhQMQsGco5do8dKeQEQ=;
        b=LgVB184nuWNpFfGTtXqtzbPQCgBsxaiS3I2ido28o3uv6Be63L007ZEgJmeI4p0/bU
         gZ6XCsGvaUXpCS9kQrcCCvJGsC6gBbU5UgGuwiQXUL2Yq7wIEFglIILOgZw8P9sQ59j7
         DVtDRA39e/w+eVu+5Fh80AmOIS+cIts7L5UOC6aEPlA7E1tDZ3rxeD/TiAUidkN3wOUr
         1nHZaIYFTXT5S+tb7PTGosHYi4WLU/P4nMLLf2YXPVRMFdaZd4mZ8LM0dz/v2xb6ZclM
         3VZLjZEqUWsplJQaLrY2K2NJQ4QLwMKeezr3/t5BIKT6nsMzzJ4vjASSNPhTr64cZv0u
         0dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tc+3dFnObbCsZTOmcaVyw6tfhQMQsGco5do8dKeQEQ=;
        b=peXn1hYKQZr5KjjmbgpAqeTPovXgp/D27LgkWkhmYeCUFXPV9XJE7iEUZH0KwUJcKI
         Cm+t0ZFsZLV1ylWDvRTyFjc1L/RqMg5Mk10iWvOHvj+rxa3DFkvTzhJyVjSC2kgBOhR1
         QAQaW/X1jyKxAdMbQO6AiAqWtlwzBM2adH3N+AoFHfnIuDU/oX2OszdMSaulVPOAwNeS
         kqnLO99zZCIA3Erh/8a9ayQdVp8JZ1Y4DpcuMo7WVmRFqAqtPPAcQCmVYzo1HDCk26dL
         fdY5RMqZmNx8EfEHnlS9Het+wD0PQ5FwGXEOBqzXK88NAhMbi26EtzC0TrOwxM9qXD5o
         HXxQ==
X-Gm-Message-State: APjAAAXOe6gcCGuSeATNhxvU4JksfsUWblMoSN7K6q+ktavA9Xpx3Gs1
        EfWGIhEWIGK81MA69EMg/N+4Xg==
X-Google-Smtp-Source: APXvYqx5C+YXiG1tSukATm3surkdJTv8OYGBUPh1k6tE3QzNgmrmLWbq9IaV79OTLCPZKjDdSzPfLA==
X-Received: by 2002:a02:b710:: with SMTP id g16mr3463376jam.111.1573153698830;
        Thu, 07 Nov 2019 11:08:18 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r1sm237453iod.69.2019.11.07.11.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:08:17 -0800 (PST)
Subject: Re: [PATCH 0.5/5] bfq-iosched: relocate bfqg_*rwstat*() helpers
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com
References: <20191106215838.3973497-1-tj@kernel.org>
 <20191107190459.GA3622521@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d34b6a3-b141-f0fe-c7e1-e68e0fa52cfb@kernel.dk>
Date:   Thu, 7 Nov 2019 12:08:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107190459.GA3622521@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/7/19 12:04 PM, Tejun Heo wrote:
> Jens, this is an extra patch to help fixing the build bug when
> !CONFIG_BFQ_CGROUP_DEBUG.  The git tree has been updated accordingly.
> Please let me know if you want the whole series reposted.

I seem to run into issues applying the series with the 0.5 added first
and with the updated patch 1. So maybe a resend isn't a bad idea :-)

-- 
Jens Axboe

