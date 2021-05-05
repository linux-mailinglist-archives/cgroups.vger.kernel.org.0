Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6852373FD0
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhEEQaw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhEEQav (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 12:30:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5066C061574
        for <cgroups@vger.kernel.org>; Wed,  5 May 2021 09:29:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x20so3439852lfu.6
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfw/1w27jQ+1kd1/o/ZKaoNFZdw2wrWkGNYntufubLI=;
        b=p2YSe1DV6VXC/+ln1rLPRfAlfTm62ZNdRtOCU0nslBEclFn5Fp/bYbHR/nXYzbreux
         mv/IKUSDCqW7kj8vpqfqNBnpkrv9R4J5YCwH8ZXd6/y18H6i9aByJpnFYGeqKGYaEsQn
         SRkvZgT0AKMy6fH8YDFi9j6ILxrgb8r1DYabgBm+Bl59frUOIGeHb5Hh/2uXfMknazDY
         bmofNuYL58HukPXDiTfHiRXcN5byb632bh3fmfcHwEAbimoddGeo5oF5yXnkOe0IoTEW
         IYZviC7CHHZP9VeRDm0QLIYQsVut+8uxSeslIel/nP6p9rH6w722p7iD+UVV608St+2O
         KbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfw/1w27jQ+1kd1/o/ZKaoNFZdw2wrWkGNYntufubLI=;
        b=TiYBrjvA4GZpUR0Lmi3psfDHsZx0dihWAGgDt6E3NzN4yoo5aQ+OqAM3trHoNgAPDH
         YMHDO+CiiqYc48D20q3VPL/iRzbnm50EOzW9G9Q5kPcAK+MbrHT357UPh3C/VuvVpRpz
         om47jYZrndkv1fM/VLYtOjTkya0jHAJi6Q7UGrslZLXCAADeIxv9144y6RsKAXaFdKRz
         Hqq2GDHcNEFwPfdf4wsmr6iQpPibn2cswOuRBmtkNakAhRWuD6Xe91k/zscm2A4e7bSB
         1TkB3CHJrp4/7EM3YHYtBWWb9I9d8pTvtcXz5bDAZ9lVKcWQbkbaMmXsPAJ88UtSlCMW
         1xCw==
X-Gm-Message-State: AOAM533Y68fjhXNyWBjEmy8g+FQRFaUtLHIljZPRmxilDS1ezRx8ivUt
        +YdtKS09MegRfM5gq+lQ9RBH01f9E94M14mcaGoIRg==
X-Google-Smtp-Source: ABdhPJxm4uLWiJAhYHP6r7fuGi6V+P2PdeM4hrI06DMAhVPoEoY1KSYXN3hhZSC0lao2L0mHxrdaFdPfcmM7XyXEpIQ=
X-Received: by 2002:ac2:5b1b:: with SMTP id v27mr7384269lfn.549.1620232192955;
 Wed, 05 May 2021 09:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210503143922.3093755-1-brauner@kernel.org> <20210503143922.3093755-2-brauner@kernel.org>
In-Reply-To: <20210503143922.3093755-2-brauner@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 May 2021 09:29:42 -0700
Message-ID: <CALvZod5H4Gsm+KFyd5NtCvZL8xYfYDU2qDsvDr+-xnqoNgog=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] docs/cgroup: add entry for cgroup.kill
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>, containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 3, 2021 at 7:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Give a brief overview of the cgroup.kill functionality.
>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
