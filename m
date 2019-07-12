Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115716714D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2019 16:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGLOZY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jul 2019 10:25:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45583 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfGLOZY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Jul 2019 10:25:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so4848888plr.12;
        Fri, 12 Jul 2019 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9L3733if1HuRLL5zZv5eZHlWQiU13iqExsAt1AQHDmY=;
        b=VSgPlNfdufMwqcv8BXKRQn84MCxQSn/4zstrvTf+cNggal8AgvbiU+yvfRo6INmcRC
         0bCXNaw4N6SMdHF45IWdRLf2OIkJrk8RNNtk+wLEZMb8rhQmo4nuJF7bbI5cwO0aaBjS
         L5F5cY0jXiBtmkuyQrZh9eOx53RNk8G4xdjpUHA+LzOmuFQbxd2zvRZ7VkicqO8ACvhF
         S4F4YqPkbSb1EPWdmUCJn8dczDJf7yNw/VTAQKPtOp1LUXx4pv+4yDXQJX46WJ0CLGgg
         iX81GXvv0/fMQDBuonE9xsfz2wNDYPx0P3Ao7I4qaFWrN6EQXMafnl6G+B0l0BSF2iOU
         GN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9L3733if1HuRLL5zZv5eZHlWQiU13iqExsAt1AQHDmY=;
        b=NBVMq82lc8zE3b4MLUHOyNwggDXERFRhmDmgwpRgEteetSc2LHpXiniOazTpn1Ne/J
         /MG2sQ4LdZpyIpdxuRZ7D2a2x9P37h9aVlKa1LnOxUcozBif3/UeZ9mksbe2cxklRSMI
         ZaID5TDm7zyhq9DXrgaetgxkeedEjBp1o7JiVQfahcRrTA2h2OwDUmW+EOjW7e6sdMtl
         0ul97fPzlHZhifv6J5Q1Gp9LGIveRzM9UIEDrlxe39PKFownyySubOiQ2LwAx1T41RKu
         IwzSyJD9myeE5QWzDry1rwN1t3pyGYWqiKG7iJ70uisDwsCCpOHlK7Aou2dm60Wxj5Qa
         osPA==
X-Gm-Message-State: APjAAAUpu9cjyO7akQyeDyOqCCitD0QoPrI+FSz4H7b9l7iBggzkQKZm
        dIYk3ceD0Z/cSb/xH/r/z5w=
X-Google-Smtp-Source: APXvYqxRUDnMu2b0NEFVFzmVA6ow3YGK/wulCBM5exjcCxQDsgflC+FNsSu/x1MkE39PUa49BC+vNA==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr11835394pln.63.1562941523495;
        Fri, 12 Jul 2019 07:25:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::47b6])
        by smtp.gmail.com with ESMTPSA id p7sm9100177pfp.131.2019.07.12.07.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 07:25:22 -0700 (PDT)
Date:   Fri, 12 Jul 2019 07:25:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add entry for block io cgroup
Message-ID: <20190712142502.GA680549@devbig004.ftw2.facebook.com>
References: <156284038698.3851.6531328622774377848.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156284038698.3851.6531328622774377848.stgit@buzz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Konstantin.

On Thu, Jul 11, 2019 at 01:19:47PM +0300, Konstantin Khlebnikov wrote:
> +CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
> +L:	cgroups@vger.kernel.org
> +F:	Documentation/cgroup-v1/blkio-controller.rst
> +F:	block/blk-cgroup.c
> +F:	include/linux/blk-cgroup.h
> +F:	block/blk-throttle.c
> +F:	block/blk-iolatency.c
> +F:	block/bfq-cgroup.c

Given that blkcg changes are often entangled with generic block
changes and best routed through block tree, I think it'd be useful to
add the followings.

M:      Tejun Heo <tj@kernel.org>
M:      Jens Axboe <axboe@kernel.dk>
L:      linux-block@vger.kernel.org
T:      git git://git.kernel.dk/linux-block

Thanks.

-- 
tejun
