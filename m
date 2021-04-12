Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB835D27E
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 23:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhDLVVe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 17:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbhDLVVd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 17:21:33 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EEDC061574;
        Mon, 12 Apr 2021 14:21:15 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 7so15832753qka.7;
        Mon, 12 Apr 2021 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MBWhgeDndp0aZntn+ODLCePsN2Avwf3xdPZInGzyS+0=;
        b=sH8Fchkq/AinteIuXtQiJD7yfb56iqLXEJgwpccdCaz/VKUDWKkOYg8QlTGqlDYVY1
         AGE8n70N/Nimrb3WC47tDMr7bO3VVaEC2MX7L3NmA9G9FsgyuBDIyvDF45nnFEprQSMj
         Or8o6NabQPDxsHDAOGyHXuKGBlI2mkIH9ipZbJSq2NlIcky98cfAso1knges3C2LnOxC
         tFMcjXdvLSuoBnPfjhfz0k5QauvhEB5qivFSeiNcFTybxSdb6PmQV6eICgUhwnK36Mu+
         1qAl6pW8cUYFFIiBze7ZHlSSvmINlqmxODdfqRv3aj7YZh37X5NNaokZQp2H2hjx+2SW
         C4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MBWhgeDndp0aZntn+ODLCePsN2Avwf3xdPZInGzyS+0=;
        b=i9721S4Lb2k1ohvXzqkpPFLcsCk4YlsnHgMhXf1YtPJ71ODpeuJQXqZw+/rCMo9ydS
         Nb+iFFXldssaEDR2QOafu4gw0pgBETWD94dD/VdduLxNOM5D4DlQRXAzdLTjMg3uTV+t
         RBNmtadiNCVM8+L4rCn4yp+mD9XrW3JhmGRDAWlEzuQRi3SrlNhWeed++7PNGaZ2kBJr
         3VmpSBFGbu2JSF8h8nrtpFN3RXwl+lQZThbLIjoA7YuePIGLeoXVqEYfooNJJYtRrrsb
         1Jv7S3RNn0iNLMAnBqprSFR6+kyrZEhlytRT7zETB8dfPFM+zF+jC4+n2aIs5LSzO1qq
         OD0w==
X-Gm-Message-State: AOAM532BK715aVw5JrCY0bKN7bALBwdzY3OJcTRtPMpiN35mqxyTlkW7
        0AZzV4XVnAGLGez64n2lxnu9UMqlL4Boag==
X-Google-Smtp-Source: ABdhPJyclj9WyOSwD/gMPEtVMelrRMq20Yb6s/3VucFal+qgGfvDWFRfMf5gYfmj9vRLqDzkivcq7Q==
X-Received: by 2002:a05:620a:714:: with SMTP id 20mr29368966qkc.192.1618262474642;
        Mon, 12 Apr 2021 14:21:14 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id q2sm396929qkj.63.2021.04.12.14.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Apr 2021 17:21:12 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: fix typos in comments
Message-ID: <YHS5yPsuQxPbzNdT@slm.duckdns.org>
References: <20210408080346.166046-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408080346.166046-1-lujialin4@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 08, 2021 at 04:03:46PM +0800, Lu Jialin wrote:
> Change hierachy to hierarchy and unrechable to unreachable,
> no functionality changed.
> 
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Applied to cgroup/for-5.13.

Thanks.

-- 
tejun
