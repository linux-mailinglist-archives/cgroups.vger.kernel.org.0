Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392FB3EDBC4
	for <lists+cgroups@lfdr.de>; Mon, 16 Aug 2021 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhHPQx7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Aug 2021 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhHPQx4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Aug 2021 12:53:56 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C663C061764
        for <cgroups@vger.kernel.org>; Mon, 16 Aug 2021 09:53:24 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so18927743otn.4
        for <cgroups@vger.kernel.org>; Mon, 16 Aug 2021 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g7L5+WzsIvTLUERtXFkH56DdEnmU2g0oMI370Ugvcmg=;
        b=vTis+s4hlAm+FTr++090MtQwF0P5/lh0FBWDSi8RTA1wUVCr0BpRfK/us9pFVxUpog
         uu6jEUL2BHfveOB48loIkRaHp5bz5albTobFZvpvuwPRAEzMEGIuPI5kuvuubBK+AOQ0
         E55mGtikm7jUclvHQ2OBlF2FM0V2wuXIbbWCANJa4VATG6XRRBq0jlpJJliUp0uUwgwB
         oVjeRBwvP53F5AFe9UvDWGAGJK354/coFul8xwoLl0TFA4DBRK1WEWtza51fjJyL/6hp
         2ENq6H7kNagObY44cbihm3AMlndCLLsjuoR24ZxXM6HUn4PiQF9lftOMb/v4/GrY6jra
         QGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g7L5+WzsIvTLUERtXFkH56DdEnmU2g0oMI370Ugvcmg=;
        b=b0qVu3QwPr7YofIElYz6mxNI98Al13+im2hon3LeFmHg9TeAgo1qYsT1T9ajoZft37
         Jc2vA6eY59/lXKO4vVp6j0ys1/CrwtA+NMyV+2MTjZd4suJutCQTVx+TYutiRK0+KMEc
         /d7hvv93k75tNW8IYiMxQkl8SFP0Ew3uIKXpxDae1iKcsaEWPy9slOJ98A87yy8GZC2w
         0PorOu+zS9OLvLLz3BsVEMAR28ybkDUSglOK+CRB659ZXuuKhkA0XCXNKW8m+QdVvzin
         h2MQlLMwB5aan27zPd+VF+Swkwqw64sGN72JOZxgSQmeEDeKpqekfrFz8/3RRXKxrixE
         CBDA==
X-Gm-Message-State: AOAM531UDG06KDMjEJs2OCLxQyTxiOHwRRdBrjvw0kxYRmfCFSiT5aPF
        e2XUDJPV9i9R4YYazRfzrPlmbA==
X-Google-Smtp-Source: ABdhPJwl6C1pb1r7w6BRQRHMIIyRy460EQOcX121G30c+MwpxTGtjhNnwgFPpxDCyviQI/c+7nJkxQ==
X-Received: by 2002:a05:6830:31ac:: with SMTP id q12mr3809057ots.152.1629132803747;
        Mon, 16 Aug 2021 09:53:23 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v29sm1190332ooe.31.2021.08.16.09.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:53:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-cgroup: refactor blkcg_print_stat
To:     Christoph Hellwig <hch@lst.de>
Cc:     tj@kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20210810152623.1796144-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e090f6f4-6f15-f917-79fd-b516c6cca656@kernel.dk>
Date:   Mon, 16 Aug 2021 10:53:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810152623.1796144-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/10/21 9:26 AM, Christoph Hellwig wrote:
> Factor out a helper to deal with a single blkcg_gq to make the code a
> little bit easier to follow.

Applied 1-2, thanks.

-- 
Jens Axboe

