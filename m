Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D452A138
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbiEQMMK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 08:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiEQMMJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 08:12:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54843384
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 05:12:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so2251499pjr.1
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=bESFS7Lce2ivS8jPv+1Tsk70w8y9oJwx0ecowrteEFU=;
        b=Y/MfMz7lk/eOpLKlFlTXgPsjibZmZaA2PbI2ucwBhDPfX/hEp9tUApYImhcgzuuYOF
         FOt0+nc+MCLbeqbOXV3FgGF3xcRDDx1sxrxkzBONsxm444eMwKGqx9Wj7nayWIJL9beT
         2QbsV6YhW75anjz5V+Xj6lKrjs26H0gANnVDdG960Z/4Y/C8knzq0Y9I2vc/PpdEnMeZ
         Er8qwMap1HyKGi9GB839aP0LGjuJNKfmJ+iP10ioCUykBwDlM0Dhj848G3NO13ISNqHw
         FbbnrNHoZK1jN2MLWHhJf/T5K2MCHbpv7+Up7vjLRjEbLdk+KUvjpfSqkW4LP1W0oWmi
         saGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=bESFS7Lce2ivS8jPv+1Tsk70w8y9oJwx0ecowrteEFU=;
        b=iMajiToGHZwJ7OTSnRfp2XQgv8hBg0WGsFJrulgoh5nmaoP2wbLhgLbYKjGy9/vLjl
         DCk+wr2P6tWK2O5NWO0VMBKn4V/lUElbGB+Gwr5AUhJbrZ4lEmp4I9hE8Pq9+yhTx1MB
         alz3a1f5tAiurWb/KcqWPE9ZI3/LCcLJBRX2xxSQAcaa1d9m3cct3NyUPu2cG+Zs/HgZ
         EBXusiG3cwpcQBzItMSLkl9kmzrE4RMAsP0HpiUPRmrSWd+XcaCmyAiIdRq1jPEZKwRs
         oYT+wYbneNfoqLTQsGNPwI2ILopyr1aJMyKgUjjF6/8mJRjG4D1lf2cZN87iHYeKd+lN
         rBig==
X-Gm-Message-State: AOAM5312wxQ3xDVsK8ITIUCqWVF249X8yLvbo4yVviM2SzKMEiAfF6fI
        4Mtj+aVxMoOyk1aWbUAtBWk1uGaGrJY4QQ==
X-Google-Smtp-Source: ABdhPJyM58heMRBrKl3W3F7/5YGtJ8zl5kVkB06f1nvAUR6q+OysmD95pkFrQWFB9HZo6ncqDmDnrA==
X-Received: by 2002:a17:90a:8b8f:b0:1df:14f4:b3d3 with SMTP id z15-20020a17090a8b8f00b001df14f4b3d3mr17417602pjn.163.1652789528065;
        Tue, 17 May 2022 05:12:08 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b0015e8d4eb25csm8986724plh.166.2022.05.17.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:12:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     w.bumiller@proxmox.com, linux-block@vger.kernel.org
Cc:     tj@kernel.org, Christoph Hellwig <hch@lst.de>,
        t.lamprecht@proxmox.com, cgroups@vger.kernel.org
In-Reply-To: <20220111083159.42340-1-w.bumiller@proxmox.com>
References: <20220111083159.42340-1-w.bumiller@proxmox.com>
Subject: Re: [PATCH v3] blk-cgroup: always terminate io.stat lines
Message-Id: <165278952418.12941.4325264956300231225.b4-ty@kernel.dk>
Date:   Tue, 17 May 2022 06:12:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 11 Jan 2022 09:31:59 +0100, Wolfgang Bumiller wrote:
> With the removal of seq_get_buf in blkcg_print_one_stat, we
> cannot make adding the newline conditional on there being
> relevant stats because the name was already written out
> unconditionally.
> Otherwise we may end up with multiple device names in one
> line which is confusing and doesn't follow the nested-keyed
> file format.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: always terminate io.stat lines
      commit: 3607849df47822151b05df440759e2dc70160755

Best regards,
-- 
Jens Axboe


