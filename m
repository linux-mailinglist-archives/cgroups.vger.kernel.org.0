Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93923456F94
	for <lists+cgroups@lfdr.de>; Fri, 19 Nov 2021 14:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhKSNaH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Nov 2021 08:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSNaH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Nov 2021 08:30:07 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EE5C061574
        for <cgroups@vger.kernel.org>; Fri, 19 Nov 2021 05:27:05 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v23so12706106iom.12
        for <cgroups@vger.kernel.org>; Fri, 19 Nov 2021 05:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=tTFVd1nWcx3/XcFWQghei7zJBEBnxYkZz8vTHO1fGeE=;
        b=AUEqQdV3wtCQoHQw3uXtTZQMCIea9TPMKqSH9B1cD/8co4jzDGxflGe06I87v4A9qZ
         jc5tKvG64fJDptVFDLqT/yBxbv9cKwLkJOodF0z3YLG+EqKKJaXV8iU3GqeisaoIL0Mw
         TBanQ1f2qFDNkSwU2cn14jYVXl5OlB64IXXKchqXlVGlLk7sLzh1Jar1N9guEthfUUwT
         yXlX078M0Xbx0RnCnFAkRDhxr4wxRw+wU3RjbSgt58pAwmsRDnxk+ZCQP9yQm0MCS4SN
         Biu6Cr5RGg7EiSSW28CI+jbgqzijwh5imiGNmDkypWlXexx752rNPvboyYI+NIW+FqBM
         rIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=tTFVd1nWcx3/XcFWQghei7zJBEBnxYkZz8vTHO1fGeE=;
        b=1M8gRn7WFNUeMTL6zcVESn2katC4rV3TWyI4tNLtbNcwEybufIqxJdniQB0N40YhVk
         Deo3lnyJfEZ48g0dGjM6T6CyE6A1tDbCGAcmgH1VaKHhhHQTf7jUSsqtJYypRm1jxj3D
         hmcxBKfq6vFbMpFu2Jd7pY/kLFFitd2jOalzix+Z/SIRHaPhTXYrog1cKOUmi3OCGfaC
         HtqKGHYobkAjFs3sQyCwzxX+Ji1C9I5JA93kO68TKVKIZt0D6mr1TX3VtzmAPGX9PbKt
         ZXFCcB/KrVGZ/lInfBVf6D6i96GW7xPppqs6eLPt7AiXmES9WAAqDI+4Kg5COHOU7U/A
         M+3w==
X-Gm-Message-State: AOAM533BXBGK1gdTG9FpHqnHVUeD4sYMpj+moHf64MuIlc5AXiE94ZIR
        PLXnwwEICumZUicwGXF9H4hO2Q==
X-Google-Smtp-Source: ABdhPJwdxk/QYrODedQdeDW6RHtyFLfIZTB8qh42VRCoIaNIJD7RZfljKbgcdEogIBxcUWxGA8GhDw==
X-Received: by 2002:a05:6602:164a:: with SMTP id y10mr5237113iow.123.1637328424840;
        Fri, 19 Nov 2021 05:27:04 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n12sm2027960ilk.80.2021.11.19.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:27:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, yi.zhang@huawei.com
In-Reply-To: <20211102020705.2321858-1-yukuai3@huawei.com>
References: <20211102020705.2321858-1-yukuai3@huawei.com>
Subject: Re: [PATCH] blk-cgroup: fix missing put device in error path from blkg_conf_pref()
Message-Id: <163732842185.43918.10012034831708951012.b4-ty@kernel.dk>
Date:   Fri, 19 Nov 2021 06:27:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 2 Nov 2021 10:07:05 +0800, Yu Kuai wrote:
> If blk_queue_enter() failed due to queue is dying, the
> blkdev_put_no_open() is needed because blkcg_conf_open_bdev() succeeded.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: fix missing put device in error path from blkg_conf_pref()
      commit: 15c30104965101b8e76b24d27035569d6613a7d6

Best regards,
-- 
Jens Axboe


