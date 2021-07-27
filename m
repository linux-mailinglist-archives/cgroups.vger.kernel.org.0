Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB673D83BF
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 01:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhG0XN0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 19:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhG0XNZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 19:13:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22551C061757;
        Tue, 27 Jul 2021 16:13:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b6so2266101pji.4;
        Tue, 27 Jul 2021 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IJH4q6xKknpFCnME1MQ4rrc80QVCXZj1Kd8DIZ0/IhQ=;
        b=RDDPk3g21uOn+gvEHvobhce6lQTn5Mq7nQNxDeFycx7c7RXn4xjZnyH/omdaeMk+O3
         bFAWs+7yxxqhCqLCMsJ9sgGr14Zxo6uVYqApMj6C2S+6L0Bw7EBgdo1njMLa8WAV8j9J
         Ydz92yY4SQZTpCctVQbhovhNiiHXHyRauzBeaWX0GqXod0tb7Hdi6/G0wflkCGXrHI55
         7IpHNYSWY2V4emWWdKAT8srhjlCD2DbZUZKyDpHDOxKfYjQLd/nXsOKBJ8Qq2NvtGlT6
         kmNTnk0xrhQsqfyd8Hho/kLvsqw+ahDCLptTC8ne7eLn7FTy7xsE1rioaqbOe64k++oF
         Ku2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IJH4q6xKknpFCnME1MQ4rrc80QVCXZj1Kd8DIZ0/IhQ=;
        b=o03IGDPAbzEQXslSu1Z0+9r1Sbb6QCM72eJrQOVq+NZ9Mjfsv73e9EJnRl5xsuNrMi
         vbArEfdKcYrDXgVykLiSPtx7o8CaWZGqx83NazNr0uebtTXQnwMfq5QRCvtOGkQIXhFq
         wpRWHHMZVz9NeswJpm34KuKncDT/+379GmBAuc8JED//ONxFBPjmWPlWKU8vZkHnQrq4
         Ja0nYzHkxjkHffcDPBfPtYXcBu1Ty/7NXMDnFKi66PLLx8Dgtd7n/sOb4CO7njFfA5pD
         DIoKUarcRrTjoLKf/34q5YVPiSsJW/4b0z/8YjdkkNXvfGdwNrxU8nk7ZphZz+heoct5
         VcoQ==
X-Gm-Message-State: AOAM530I6QVprKcJJ5YzZly+Z6a+6HVKSwmc2YyupbrlPDNrF6iqqbes
        x14Q9AIrhVwAkccbojqmn2VyNkN9VBo=
X-Google-Smtp-Source: ABdhPJw7ZJUYZvGDREE8f3L7AQhb0lBZFKoBC+rMUzXEn0SUupttLTCzixCk4o5VCsGhaE+mAvbqkA==
X-Received: by 2002:a63:d311:: with SMTP id b17mr25427653pgg.332.1627427603103;
        Tue, 27 Jul 2021 16:13:23 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id x189sm5563989pfx.99.2021.07.27.16.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:13:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jul 2021 13:13:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH cgroup/for-5.14-fixes] cgroup: rstat: fix A-A deadlock on
 32bit around u64_stats_sync
Message-ID: <YQCTEYhcxKccOamq@slm.duckdns.org>
References: <YQCREXMBq1EPoQWu@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQCREXMBq1EPoQWu@slm.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 27, 2021 at 01:04:49PM -1000, Tejun Heo wrote:
> 0fa294fb1985 ("cgroup: Replace cgroup_rstat_mutex with a spinlock") added
> cgroup_rstat_flush_irqsafe() allowing flushing to happen from the irq
> context. However, rstat paths use u64_stats_sync to synchronize access to
> 64bit stat counters on 32bit machines. u64_stats_sync is implemented using
> seq_lock and trying to read from an irq context can lead to A-A deadlock if
> the irq happens to interrupt the stat update.
> 
> Fix it by using the irqsafe variants - u64_stats_update_begin_irqsave() and
> u64_stats_update_end_irqrestore() - in the update paths. Note that none of
> this matters on 64bit machines. All these are just for 32bit SMP setups.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Rik van Riel <riel@surriel.com>

Applying this to cgroup/for-5.14-fixes with stable tag added.

Thanks.

-- 
tejun
