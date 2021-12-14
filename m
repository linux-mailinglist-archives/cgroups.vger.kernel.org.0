Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE556473AF3
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 03:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbhLNCu7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 21:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbhLNCui (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 21:50:38 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB1C061751
        for <cgroups@vger.kernel.org>; Mon, 13 Dec 2021 18:50:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so16106535pja.1
        for <cgroups@vger.kernel.org>; Mon, 13 Dec 2021 18:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=QWQlvQssHrsTkmhAcYEyHsS+/G2qMiumDXBWc6CQdPo=;
        b=3h0OwKWCGXfI8pNcGzPhZHOkgihKsvKdmRRC2Gqv0AznLP9nxEcI3vAyIa3rjHnq0c
         Ns7W5Yt7y0ycNFkN70oSiEjPUy4z+wcDE+7UVedsF563i/iVbNS4n2LoStcLHCiDItwF
         QquCs6gnpalfdlidWc3DiJ932MrMOK4uhK0xVL01rTH5Ivn87KlomlLKXmjBvn3lAERt
         t9n/k0uVMPChhJBsCSkM7DIJeAJ8X0kt7vuilgVHi9y3Bvo8sXn59VaikU19J9GJwJq3
         DVXSFubI4QtWFikgeEoAqjSBDKC3HgmfUN/OfBCKTTUFlYhTfxNkxE8SXJE72EsDRtnX
         7kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=QWQlvQssHrsTkmhAcYEyHsS+/G2qMiumDXBWc6CQdPo=;
        b=hzAQ0VwOaW7VNVdQrKe3JuyasvFYycUKsgjKuuS4Ad4WmVecCTXRxwaz/QKKUZ48HL
         wSiWbHZvQj0u5eKQmYx8qIcMbK8NBEyl19rdFrS+M8GnKLhRJVl4mhflZ5awc+p0rR4J
         X8ujD9c5evQWpnSsqSbiBGN/LBAOwS2FEXjtmty/5zQ7T8+aHKC/7BCtO/sYbTUvW3N/
         FYiqRKW5wMu579z4cHz9Gby5XNgnQBSHFGq5Cn3R31uwDkh+Bau73xaSRB1W4PrIMvmW
         xyqNVT9HIyCVb57nGop3HZyD6WlMhAPlwUX7WS5kvPom6wbTNfixNq5HDuGmc4lrn0GO
         7T3g==
X-Gm-Message-State: AOAM530JVSzgaMChGLf2msU/u0PT4QDTHF8EBX03IsaGpgAxjUd1NvQY
        78OiKlw31CyL5U8mTpOuf4/6qw==
X-Google-Smtp-Source: ABdhPJxIc8vigpQDm7p2mih+0Ad94BeKA2H3FSD+oGZxYF+k7+fBqF/V6PVRvu9C0sHUwpPfporoow==
X-Received: by 2002:a17:902:c7c4:b0:141:deb4:1b2f with SMTP id r4-20020a170902c7c400b00141deb41b2fmr2812337pla.44.1639450237360;
        Mon, 13 Dec 2021 18:50:37 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id g1sm12831489pfu.73.2021.12.13.18.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 18:50:36 -0800 (PST)
Message-ID: <a6aa93b2-cb28-6d79-10ef-7b18bae11231@bytedance.com>
Date:   Tue, 14 Dec 2021 10:50:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
To:     wanghonglei@didichuxing.com, tj@kernel.org
Cc:     bristot@redhat.com, bsegall@google.com, cgroups@vger.kernel.org,
        dietmar.eggemann@arm.com, hannes@cmpxchg.org,
        jameshongleiwang@126.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, tj@kernel.org, vincent.guittot@linaro.org
References: <20211213150506.61780-1-wanghonglei@didichuxing.com>
Subject: Re: [RESEND PATCH RFC] cgroup: support numabalancing disable in
 cgroup level
Content-Language: en-US
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20211213150506.61780-1-wanghonglei@didichuxing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,
How about my per-process numa balancning patch;)

https://lore.kernel.org/all/20211206024530.11336-1-ligang.bdlg@bytedance.com/
-- 
Thanks
Gang Li

