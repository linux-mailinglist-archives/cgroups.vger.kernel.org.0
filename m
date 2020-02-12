Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F5615B34A
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2020 23:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLWAZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 17:00:25 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40362 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWAY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 17:00:24 -0500
Received: by mail-qv1-f65.google.com with SMTP id q9so761121qvu.7
        for <cgroups@vger.kernel.org>; Wed, 12 Feb 2020 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J3XSJleCuaTuotjsG7Nz7OJ9sisD14+N/U/FPfy3Kas=;
        b=Rgj5oM2AgQOyAIVwpO9FUEqEuYh2rq1Qcs8tdtwXgmu7UV9lRMr8F0eS+J0E3hiIdh
         2qvJAUtnDeKSs1qjhoObSmsaPleyLyTXuxYhyHyMTqFdUN2s7MAGBDhNevco6a+Zcyqs
         wkNG9AlCj7a0IySqIPWa2YsnooUtLDnzKMCYO5xJdTNmkFKRrS2kTw2qoyYw1UasjufF
         PEYg9Lgu9hE/VbDESGvYwQGF/otYOgmHXc11u8Wwqq7A3vtHYH72vhiohqoJkxlPe2/8
         xo2aFXcZ2QMv2u+QuyeRbZ5xJisVT00t2sjQ/k1nGf1aDQQ5HoKGiN7D0OatjYC4pugh
         V/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=J3XSJleCuaTuotjsG7Nz7OJ9sisD14+N/U/FPfy3Kas=;
        b=fSKy6Aqh+1Iq52O8PbUzCpt52VrlZECBrw+Ne19l4PmjDrhmFNaWmAJLD6WVLjYFQz
         pF7uWPCwgDLdh3bmr1iVDP8K5i8Dlrw2rJ2yOIDun+FtI2/5Mk7p7n7IiF4jbQG8vIhs
         che0ukQi97Vwc1+QrXQf0oKoRtwmX5by5XAn8duaFmXJfGfn8pB3+EpzafP9wq8cS98+
         5e8U341V0yJnQPnpCEEQD0nvLgRJHAhvZhou5fdXdwK/AJjnL8Jk5vwe3I8MPh2jvWco
         5GU3iJazH/dyoEiD6D618kJlFOzVf5oSa2jCHb+eh8RkDlDWJLK1mTqimWxA6EaMV8M0
         9YRw==
X-Gm-Message-State: APjAAAXEufOflozmC/+F3O4pnG1HlXfNdMwngXrjifc6lHrq/KIvhYOw
        VLPSUDRSQg/ffGxetYqJMTs=
X-Google-Smtp-Source: APXvYqzHnouTyCkGnhrlqIpzJioazUyXTgYMP8hGiVWkTaJYGJvOFjX4lb7OpQxKAcBfuMQ3qA6y4A==
X-Received: by 2002:ad4:450a:: with SMTP id k10mr8598482qvu.136.1581544823624;
        Wed, 12 Feb 2020 14:00:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id s26sm153229qkj.24.2020.02.12.14.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:00:23 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:00:22 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2 2/2 RESEND] cgroup: cgroup_procs_next should increase
 position index
Message-ID: <20200212220022.GG80993@mtj.thefacebook.com>
References: <20200128172737.GA21791@blackbody.suse.cz>
 <821bde4f-bdaf-994c-d864-a8a97d7d6b13@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821bde4f-bdaf-994c-d864-a8a97d7d6b13@virtuozzo.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 30, 2020 at 01:34:59PM +0300, Vasily Averin wrote:
> If seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output:

Applied 1-2 to cgroup/for-5.6-fixes.

Thanks.

-- 
tejun
