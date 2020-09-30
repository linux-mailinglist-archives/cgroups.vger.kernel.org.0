Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC127F0DF
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 19:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgI3Rwk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgI3Rwk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Sep 2020 13:52:40 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CADCC061755
        for <cgroups@vger.kernel.org>; Wed, 30 Sep 2020 10:52:40 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k25so1929061qtu.4
        for <cgroups@vger.kernel.org>; Wed, 30 Sep 2020 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GCAh8TaPpWaB6i2tYN+N4CwVQbHEcbrNvzTWfAuRh9w=;
        b=SmnTN5JLJdnYnVJlUAHKELGi4p1DcSzStBRPB8fdE8xH8WGwAGAhuUoZihOOE9+pL9
         3vNIfAS5q1AP7H/8g79G3wKBlIV89ZKJGX/eEeB1Q3P9673YFvfutRbzF1C9ybLlnfLt
         HjifyZx8YP1h3stPia1BTVeCzuljidNXSw1kfKrGjhTsHtjaoPy1gl+N2gf3KlpQ7H8D
         Rlsy8p7DJnDBjsH3z1qQg0IdgE2+4SSCnERuPjgQa1T6M/ik/23/3GBFS7wQ4r9qdkmQ
         7Df0RgkQghrC85auaOsiVSFxTt6Eu8SQ4eCC+NRC07Ker0YoC+CdfOwwtVoavhwXeNz0
         oxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GCAh8TaPpWaB6i2tYN+N4CwVQbHEcbrNvzTWfAuRh9w=;
        b=t0WbFcJo95jr37DNniN7KtxKrBV76Vippiz8OtYydnKoMmDaZHlMWdoAtsN52ePesb
         GpEZCOTuiW4Hk0GoBdQq5rIctGZSW6fnuUKgXQZvDEPk08w6hWlRdv4TL2n0O4mR51+8
         qW4YeAki8zdL9GG7wKL62kAuz+tP5Kgs2seAH+vmXIbBMvPBgMgEjpokxDFee706KA6/
         jVd8GFzA5r5XrU+wAaMy3g41eooKJ6VPzc7ucCWX84AdDg1GaoTuwNUXpY+39aRmFIZY
         faV+0K3vRQjJR+XreLHZFXDcjzQmie9YpWpbsPirhxY81FOrzkjv/SiY/LFQE4sX7oCb
         YgQw==
X-Gm-Message-State: AOAM531Zs9TCm+AZP6WA2lh3zMr4aByg2/wFY1k9oomFCYErQ81afDPM
        kTJLAf3FPvqI6oeg4zkv4Mk=
X-Google-Smtp-Source: ABdhPJz0o6fWA5fk2iGg4/IAjG5MphlU1EVch5bFvK+LMUgROgm3/jT5JxC992Xw3L9ONWOZTbFhKQ==
X-Received: by 2002:ac8:1b92:: with SMTP id z18mr3329072qtj.265.1601488359659;
        Wed, 30 Sep 2020 10:52:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fa])
        by smtp.gmail.com with ESMTPSA id u10sm2895912qkk.14.2020.09.30.10.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 10:52:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Sep 2020 13:52:37 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jouni Roivas <jouni.roivas@tuxera.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: Zero sized write should be no-op
Message-ID: <20200930175237.GH4441@mtj.duckdns.org>
References: <20200930163435.GB304403@tuxera.com>
 <20200930164242.332249-1-jouni.roivas@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930164242.332249-1-jouni.roivas@tuxera.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 30, 2020 at 07:42:42PM +0300, Jouni Roivas wrote:
> Do not report failure on zero sized writes, and handle them as no-op.
> 
> There's issues for example in case of writev() when there's iovec
> containing zero buffer as a first one. It's expected writev() on below
> example to successfully perform the write to specified writable cgroup
> file expecting integer value, and to return 2. For now it's returning
> value -1, and skipping the write:
> 
> 	int writetest(int fd) {
> 	  const char *buf1 = "";
> 	  const char *buf2 = "1\n";
>           struct iovec iov[2] = {
>                 { .iov_base = (void*)buf1, .iov_len = 0 },
>                 { .iov_base = (void*)buf2, .iov_len = 2 }
>           };
> 	  return writev(fd, iov, 2);
> 	}
> 
> This patch fixes the issue by checking if there's nothing to write,
> and handling the write as no-op by just returning 0.

Applied to cgroup/for-5.10.

Thanks.

-- 
tejun
