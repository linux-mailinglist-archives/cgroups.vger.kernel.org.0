Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383772CBE1
	for <lists+cgroups@lfdr.de>; Mon, 12 Jun 2023 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjFLQxR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jun 2023 12:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjFLQxR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jun 2023 12:53:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657B6E78;
        Mon, 12 Jun 2023 09:53:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3ca7d007bso8890455ad.1;
        Mon, 12 Jun 2023 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686588795; x=1689180795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ozLmxcHZko0uff1gJa7G1QuMp/af47NfMEu+aumDRk=;
        b=asziyJYziIWdTbh13EtSN26YuTiEk9fqzksOwuGlBXMDRQlxXgFKs0Cmz8sA0AQvQI
         te9sSY4n2RSu097TwpQepts33BOL4AM4tWhSoq16SFnU/pUi4Gh9GV4O3FXl8uMZI4Kc
         PuO8tC367euVqlNHJthw0XZD4jTE7GPu3ZBE6ZCxK6iAaz22sJ+hbgv3oMcaSM/qvJPo
         m1GKXkaX0/tTej1Ev5OnP599v1D0QEgJAUf8werx4bdtAc9GUfy7fdC7hVu22CipHpaL
         AMb/5zNHy/HHh5G6pgp1SvC96x0k03yWCQ/jTmtnIqF0dwU9VflYqlslyDwyXtDw6l1n
         ZKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686588795; x=1689180795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ozLmxcHZko0uff1gJa7G1QuMp/af47NfMEu+aumDRk=;
        b=mCV0H3ExgpyE5LG6oi6yFfH7QK0/CKXr7zVgL3cVqWTNw9szn6tVE/6WAJ+Q/bNRXN
         jXRXAfyBAvRn/CZlgEV7vd1SqJW+nAMytCKvQ44x/eF0Ofn+2zwa3mTIb+MTO3jx6hIs
         r62NyU23gXZdh76IbF6W1WOue7vgh7LqSoETpvhFBmniJmdYmAMQSA6hdKwjI0l2fOAa
         A61v4QZWDnl0ojNYeWsMexUtA5z8TUaXQyWqg8bEOW4ZvOuX7rZ749l0087ZL31rsSw3
         K2GnVrqfjYayQ9HhSKYXZvZirjvvKqcjLkQ9fRPyWN+AILQSUCmJ7L8xBDghF811A9HG
         vLmg==
X-Gm-Message-State: AC+VfDxe3WiUWDghGdhM51k/jJTWcGGAHu2246vuGaStEW83OxQax+9s
        1WmnvE+8QHFm717Ln3YrYt8=
X-Google-Smtp-Source: ACHHUZ5h9IkDbJWAzZrxwod1hhhHIkxZ2hCK60hHe9qC+4vzB1j4g6pYzjgZfbfoTLr96avHEsgTNA==
X-Received: by 2002:a17:903:2341:b0:1b2:28ca:d30 with SMTP id c1-20020a170903234100b001b228ca0d30mr8760757plh.10.1686588794624;
        Mon, 12 Jun 2023 09:53:14 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001b3d7205401sm1710882plb.303.2023.06.12.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:53:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jun 2023 06:53:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     longman@redhat.com, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: remove unneeded header files
Message-ID: <ZIdNfTyyoaZ5Ybpr@slm.duckdns.org>
References: <20230610064138.1472319-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610064138.1472319-1-linmiaohe@huawei.com>
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

On Sat, Jun 10, 2023 at 02:41:38PM +0800, Miaohe Lin wrote:
> Remove some unnecessary header files. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
