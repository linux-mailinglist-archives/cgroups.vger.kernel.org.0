Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A68E5351DB
	for <lists+cgroups@lfdr.de>; Thu, 26 May 2022 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbiEZQKL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345136AbiEZQKK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 12:10:10 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9315DA77
        for <cgroups@vger.kernel.org>; Thu, 26 May 2022 09:10:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id r84so1742610qke.10
        for <cgroups@vger.kernel.org>; Thu, 26 May 2022 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDIN0F8mvUcIGsiOah6JCrzsC64603zfSeEz/dKmMio=;
        b=olZ/4QEjQFmPMP59XTnjcoZ/IIDwnh9ZjBNh4mITNRa2SGio88rIvmn77mWSmsyhnS
         1+My7HsltQdc2zU6sKYLAIOvlxtEKbLNq2RZTXfRw0rh+WjeBDqAoOQ7QuUvnqwko4zG
         Bp7b8/ThHTGaoJx7noACCWKr7TdO/piuRapEvKlkkx65IDM6tZN7NCywfKkjvdid0Gzh
         jYLbsfouWZFQoOxa4OaCfLwhg7wXO1UtTCzjzuaZ0+6TmoEwsfvfyl3vi7ZpufE2/uSf
         7U9QTSX8VJbSStJcKOUtySPIl/D9jnDea58T6Pa7IWCpmu/uPqbo0d0KPakyfxrK3MrG
         W8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDIN0F8mvUcIGsiOah6JCrzsC64603zfSeEz/dKmMio=;
        b=e/CCrbj7c9k7OUK/P/bup5EE7xlwvCzDV6Np94M8akqsnxLGe8K0Htakm3I0MgErk+
         j8ODcngYC7VIGszQjUZCF1v2zjhVzw4Qkn2I0v7ERhaIFy5NYuPF7BdzvydgpjzTAUJQ
         ij7A0LTG+Mamzfpo83BOGrsNzp1hniLv3ZAlPAklqLDh+9FhGrcvlLaJOIudi1DXMTqp
         TxLj6rhLKoWiUnjGqUkOKuA9btBBFFmlIF2zn3UhN/wTtkq3lRTdEsQOjcNP3bJkFJcK
         g4d5ffaJ6OUnQTC8EtJTzs+Csesjik7sXI5NiVshXeip8+Utl0mKgMIzVe0d3XakLbWL
         R+nw==
X-Gm-Message-State: AOAM532ppMstxvO/FEWFAsw51YOhrzphNVhWqfqlz6N0IFNhlBMVlrRI
        8kJkthlhiNQmfEkPeemoOhyvMg==
X-Google-Smtp-Source: ABdhPJwWDDPpOK2Oam8oC99sF4AC4iytJehmaj8jpxxFCrtfaba4mI/AWygBRChYU9ctBwaIY3oKlw==
X-Received: by 2002:a37:be06:0:b0:6a1:429:a49f with SMTP id o6-20020a37be06000000b006a10429a49fmr24912713qkf.6.1653581407480;
        Thu, 26 May 2022 09:10:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id 2-20020a370802000000b0069fc13ce204sm1353030qki.53.2022.05.26.09.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 09:10:06 -0700 (PDT)
Date:   Thu, 26 May 2022 12:10:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, surenb@google.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: dont alloc memory for psi by default
Message-ID: <Yo+mXVefsRSxjTMY@cmpxchg.org>
References: <20220526122656.256274-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526122656.256274-1-chenwandun@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 26, 2022 at 08:26:56PM +0800, Chen Wandun wrote:
> Memory about struct psi_group is allocated by default for
> each cgroup even if psi_disabled is true, in this case, these
> allocated memory is waste, so alloc memory for struct psi_group
> only when psi_disabled is false.
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

Looks good to me,
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Tejun, would you mind taking this through the cgroup tree?
