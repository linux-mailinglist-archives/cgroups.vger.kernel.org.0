Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90FC52E68F
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbiETHvV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346641AbiETHvT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 03:51:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B4335;
        Fri, 20 May 2022 00:50:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f10so7354968pjs.3;
        Fri, 20 May 2022 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YlH159IcSNXAnSMmJrm8SPIzKKgsdQNyWHqQ6RmP5X8=;
        b=UFMQ6EQgUHKYqvJqw5I6s0P7kMn6UxEfOGOyCHgjfGaTURsUdYbkyHzzQNaiSkc0B8
         kzo2XZXZ9YsddgW/3uR4CTQ49h2BWa17hKYq3sFHmshzOxgYsIOtGAQKCZEWty554kys
         Cp+JrBH/gYGExZiKTJzX7MyD9EcAeSczl6tQ1SohJuptWykoZcNPfK4YlyGmY24LsTWG
         Iwcbb2ILRU33S13LSaKFCK2mJntHkAXligibXRmYhjSIB/en61VfXoz0vLqiyYDMo71p
         fbR+7X7qgWrbdwGihSZdWt1PZ3Ii/ayrpduRnCLwcysQ7ZDEVmAs7O6VJE1Z7KM5DkOl
         LQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YlH159IcSNXAnSMmJrm8SPIzKKgsdQNyWHqQ6RmP5X8=;
        b=Jpv1kcr19gN7pIke43XedcGVEVKupKbiRslITe8JJDDJH198zcZjAbvD68syIc1d/5
         2hHgiRqJoAeXdtr3LBRYA078+qBpPOF2t03jrOFiG6s+YNspha0dFDyR2O+0rZFv5qgd
         aJk/aoLDT2eNUENjyg1VP8mDJ02sY9Gpj6zBn5GfM4mGr3FbdinjDdzfUZFIWcBCE9ha
         ZQ5AzmMttLKnzkrGmlCCmOzh9DLz5Rs1zsh6Qaqj5feTRdX0X86R5A97V12ICIyGw5a2
         2NYdDgxGQ49vnQNMVsyWUGvDVmMAL3c87vA+NBqCaq2C4mbiuNjCq0XFacRRqdj1KH27
         BFQw==
X-Gm-Message-State: AOAM533u+aUTvaZamkyhZ52V6NM18JfJ/m03J6ycxg1F6X766q81GDXw
        jnUxQag9gClrEdc8ZU73q2IdsRIre54=
X-Google-Smtp-Source: ABdhPJwE8KcWrrWcyZwZjrXCxLx99rVuSOz/yzpbM6ERGWN7qY/MeDDOy/Z+8blksEJUtYx3KwpWlg==
X-Received: by 2002:a17:902:8608:b0:158:c532:d8b2 with SMTP id f8-20020a170902860800b00158c532d8b2mr8650398plo.46.1653033059309;
        Fri, 20 May 2022 00:50:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b005181133ff2dsm1077631pfh.176.2022.05.20.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:50:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 May 2022 21:50:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shida Zhang <starzhangzsd@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: remove the superfluous judgment
Message-ID: <YodIYdu0T+HYKlY7@slm.duckdns.org>
References: <20220518013647.1749568-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518013647.1749568-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 18, 2022 at 09:36:47AM +0800, Shida Zhang wrote:
> Remove the superfluous judgment since the function is
> never called for a root cgroup, as suggested by Tejun.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

Applied to cgroup/for-5.19.

Thanks.

-- 
tejun
